
const main = async() => {
    const [owner,randomPerson]= await hre.ethers.getSigners();
    const waveContractFactory=await hre.ethers.getContractFactory('WavePortal');
    debugger;
    const waveContract= await waveContractFactory.deploy({value:hre.ethers.utils.parseEther("0.1")});
    await waveContract.deployed();

    let  balance =await hre.ethers.provider.getBalance(waveContract.address);
    console.log('Contract deployed:',waveContract.address);
    console.log('Contract deployed by:',owner.address);
    console.log("contract balance", hre.ethers.utils.formatEther(balance));
    let waveCount;
     waveCount= await waveContract.getTotalWaves();
    console.log('initial namaste count :',waveCount);
    let waveTxn= await waveContract.wave("logging first time");
    await waveTxn.wait();

    let waveTxn2= await waveContract.wave("logging second time");
    await waveTxn2.wait();
   /*  waveTxn = await waveContract.connect(randomPerson).wave("test2");
    await waveTxn.wait(); */
    
    balance =await hre.ethers.provider.getBalance(waveContract.address);
    console.log("contract balance", hre.ethers.utils.formatEther(balance));
     waveCount= await waveContract.getTotalWaves();
     console.log('total namaste count :',waveCount);
   let  waveCountArr= await waveContract.getAllWaves();
     console.log('List of addresses with their messages: ',waveCountArr);


}

const runMain = async() => {
    try{
        await main();
        process.exit(0);
    }catch(error){
        console.log('Error!,detailed error message:',error.message);
        process.exit(1);
    }
}

runMain();