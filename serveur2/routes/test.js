const {spawn} = require('child_process')

//const childPython = spawn('python',['test.py'])
obj ={ projet: 'Sattageny' }
const childPython = spawn('python',['../matchingAlgo/test.py',JSON.stringify(obj)])

childPython.stdout.on('data',(data)=>{
    console.log(`stdout: ${data}`)

})

childPython.stderr.on('data',(data)=>{
    console.error(`stdout: ${data}`)
    
})

childPython.on('close',(code)=>{
    console.log(`child process exited with code: ${code}`)
    
})

