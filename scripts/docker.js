const MASTER_FLIXEL_GIT = process.env['FLIXEL_GIT'] || '4.2.1'
const TRAVIS_BRANCH = process.env['TRAVIS_BRANCH'] || ''
const isMasterBranch = (/master/.test(TRAVIS_BRANCH))
const isBuildArg = arg => /--build-arg/.test(arg)
const isFlixelGitBuildArg = arg => !(/--build-arg FLIXEL_GIT=/.test(arg)) && isBuildArg(arg)
const FLIXEL_GIT_BUILD_ARG = `--build-arg FLIXEL_GIT=${MASTER_FLIXEL_GIT}`
const IMAGE_NAME = 'haxeflixel-builder'

const execSync = require('child_process').execSync
const exec = (command) => {
    console.log(`execSync command: ${command}`)
    return execSync(command, { cwd: __dirname, stdio: 'inherit' })
}

const cliArgs = process.argv.slice(2)

switch (cliArgs[0]) {
    case 'build-image':
        buildImage(cliArgs.slice(1))
        break
    case 'build-demos':
        buildDemos(cliArgs.slice(1))
        break
    default:
        console.log(help)
}

function buildImage (args) {
    let buildArgs = args
        .map((arg, index, args) => /--build-arg/.test(arg) ? `${arg} ${args[index + 1]}` : arg)
        .filter(arg => isMasterBranch ? isFlixelGitBuildArg(arg) : isBuildArg(arg))
        .join(' ')
    buildArgs = isMasterBranch ? [FLIXEL_GIT_BUILD_ARG, ...buildArgs] : buildArgs

    const command = `docker build ${buildArgs} -t ${IMAGE_NAME} .`
    const buildCommand = exec(command)
    console.log(`build command completed with ${buildCommand}`)
}

function buildDemos () {
    const CONTAINER_NAME = runContainer()

    exec(`docker exec ${CONTAINER_NAME} haxelib run flixel-tools bp html5 -verbose -server -O-final -Dwebgl`)
    console.log('Built the demos now copying them to your cwd')

    exec(`docker cp ${CONTAINER_NAME}:/root/demos/server/ .`)
    console.log('Completed, check your cwd for a server folder')
}

function runContainer () {
    const CONTAINER_NAME = 'haxeflixel-build-demos'
    console.log(`Starting docker ${CONTAINER_NAME}`)

    const CID = exec(`docker run -it --name="${CONTAINER_NAME}" -d ${IMAGE_NAME}`)
    console.log(`container started ${CID}`)

    return CONTAINER_NAME
}
