const main = async() => {
    const [deployer]= await hre.ethers.getSigners();
    //const depBalance= await deployer.getBalance();
    const waveContractFactory=await hre.ethers.getContractFactory('WavePortal');
    debugger;
    const waveContract= await waveContractFactory.deploy({value:hre.ethers.utils.parseEther("0.01")});
    await waveContract.deployed();
    console.log('Contract deployed:',waveContract.address);
    console.log('Contract deployed by:',deployer.address);
    let  balance =await hre.ethers.provider.getBalance(waveContract.address);
    console.log("contract balance", hre.ethers.utils.formatEther(balance));
    //console.log('Deployer account balance:',depBalance.toString());
    
    /* let waveCount;
     waveCount= await waveContract.getTotalWaves();

    let waveTxn= await waveContract.wave();
    await waveTxn.wait();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();
    

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

     waveCount= await waveContract.getTotalWaves(); */

     


}

const runMain = async() => {
    try{
        await main();
        process.exit(0);
    }catch(error){
        console.log('Error!, detailed error message: ',error.message);
        process.exit(1);
    }
}

runMain();