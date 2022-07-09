//SPDX-License-Identifier: 0BSD
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal {

struct Waver{
  address adrs;
  string message;
 // uint256 indWavesCount;
  uint256 timeStamp;
  
}
uint256 private seed;
 Waver[] waversList;
uint256 totalWaves;
 event NewWave(address indexed from, uint256 timestamp, string message);
 mapping (address=>uint256) public lastLoggedTime;
mapping (
    address => Waver) waveCountForEachWaver;
 address[] public waverList;

  constructor() payable {
  console.log('Iam a Buildspace smart contract');
  seed=(block.timestamp + block.difficulty)%100;
  }

  function wave ( string memory message) public {

    require(lastLoggedTime[msg.sender]+30 seconds < block.timestamp,"please wait for 30 seconds");
   /* if(lastLoggedTime[msg.sender]+15 minutes > block.timestamp)
   {
    require(false,"error");
    console.log("Please wait for 15 min to do namaste");
   } */
   
   //console.log("logged time:",block.timestamp);
   lastLoggedTime[msg.sender] = block.timestamp;
    totalWaves+=1;
    waversList.push(Waver(msg.sender,message,block.timestamp));
    seed=(block.timestamp + block.difficulty+seed)%100;
    console.log('seed:',seed);
    //emit NewWave(msg.sender,message,block.timestamp);
    emit NewWave(msg.sender, block.timestamp, message);
    if(seed<=50)
    {   
       console.log('%s has won 0.0001 ether:',msg.sender);
       uint256 prizeAmount= 0.0001 ether;
        require(prizeAmount <=address(this).balance ,"Contract  doesn't have funds to process this request");
        (bool success,)=(msg.sender).call{value:prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }
 /*    if(waveCountForEachWaver[msg.sender].indWavesCount==0)
   { 
     waverList.push( msg.sender);
   }

    waveCountForEachWaver[msg.sender].indWavesCount+=1;
    waveCountForEachWaver[msg.sender].message+=1;
    waveCountForEachWaver[msg.sender].timeStamp=1; */

    console.log('%s has done Namaste with message as: %s',msg.sender,message);

   
  }

function getAllWaves() public view returns(Waver [] memory){
return waversList;
}

  //function getTotalWaves() public view returns(address[] memory, uint256[] memory) {
    function getTotalWaves() public view returns (uint256 ) {
    // console.log('Total number of Namaste made by each individual is shown below');
    console.log('Total number of Namaste:',totalWaves);
    return totalWaves;
    // address[] memory addrs = new address[](waverList.length);
    //     uint256[]  memory tempWaves = new uint256[](waverList.length);
    //     if(waverList.length==0) {
    //       console.log('No one has done Namaste till now');
    //     }

    //     for(uint i=0;i<waverList.length;i++)
    //     {
    //       addrs[i]=waverList[i];
    //       tempWaves[i]=waveCountForEachWaver[waverList[i]].indWavesCount;
    //       console.log('Total no of Namaste by address:%s is %d',waverList[i],tempWaves[i]);
    //     }

    //     return (addrs, tempWaves);
   // return waverList.totalWaves;
  }
}
