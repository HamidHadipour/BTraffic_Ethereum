// SPDX-License-Identifier: MIT
//pragma solidity >= 0.4.22 <0.8.0;
//pragma solidity ^0.8.7;
//pragma solidity <=0.8.10 >=0.4.22;
import "@nomiclabs/buidler/console.sol";
//import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import "@openzeppelin/contracts/math/SafeMath.sol";

pragma solidity >=0.4.24;

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

contract Btraffic {
    struct userIdentityStructN {
        address waletAddress;
        //string plateNumber;
        uint256 reqTime;
        // uint256 gps;
    }

    struct userIdentityStructF {
        address waletAddress;
        //string plateNumber;
        uint256 reqTime;
        // uint256 gps;
    }

    uint256[] public timesArray_count_normal;
    uint256[] public timesArray2;
    uint256[] public timesArray_lna;
    address[] public NormalAddressesArray;
    address[] public NormalAddressesArray_lna;
    address[] public fastAddressArray;
    address[] public listOfNormalAddresse_main;
    uint256 z;
    uint256 z_count_normal;
    uint256 public newTime3;
    uint256 public z3;
    uint256 public recentPrice = 2000000000000000 wei; //set price in wei (it is 0.001 eth)
    uint256 Normals;
    uint256 temp;
    uint256 temp_count_normal;
    uint256 newTime;
    uint256 i = 0;
    uint256[] public lookingTimes_count_normal;
    uint256[] public lookingTimes_lna;
    address[] public lookingAddress;
    address[] public lookingAddress_lna;
    uint256 price;
    uint256 money;
    uint256 dividedPrice;
    bool fastUserAnswer;
    uint256 receivedMoney;
    // userIdentityStruct userInfo;

    mapping(uint256 => userIdentityStructF) public FastDriverMap;
    mapping(uint256 => userIdentityStructN) public NormalDriverMap;

    mapping(address => uint256) public AddressToFundsReceived;

    uint256 public normalCounter;
    uint256 public fastCounter;

    //
    mapping(address => uint256) public testNormals;

    /*
     our needs to mapp
     1. No list
     2. Yes list
     
    
    */
    function showTime() public view returns (uint256) {
        return block.timestamp;
    }

    function myMain(
        bool _fastOrNot,
        address _waddress,
        uint256 id
    ) public {
        bool lastAnswer;
        uint256 currentTime = block.timestamp;

        // console.log("time", _time);
        if (_fastOrNot == false) {
            NormalDriverMap[id].waletAddress = _waddress;
            NormalDriverMap[id].reqTime = block.timestamp;
            normalCounter = normalCounter + 1;
            console.log(
                "normalDriverMap_address = ",
                NormalDriverMap[id].waletAddress
            );
            console.log("normalDriverMap_time = ", NormalDriverMap[id].reqTime);
            console.log("id = ", id);
            console.log("normalCounter", normalCounter);
            // console.log("time", block.timestamp);
            //revert("You can drive through normal lines");
        }
        if (_fastOrNot == true) {
            Normals = countNormals(block.timestamp);
            console.log("number_normal_final", Normals);

            if (Normals == 0) {
                console.log("You can go in free as the normal lines are free.");
                FastDriverMap[id].waletAddress = _waddress;
                FastDriverMap[id].reqTime = currentTime;
                fastCounter = fastCounter + 1;
                console.log("Number of fasts =", fastCounter);
            }
            if (Normals != 0) {
                // price = calcuPaymentAmount(currentTime);
                //  money = AskToPay(price);
                FastDriverMap[id].waletAddress = _waddress;
                FastDriverMap[id].reqTime = block.timestamp;
                fastCounter = fastCounter + 1;
                dividedPrice = recentPrice / Normals;
                //console.log("before getting list of normals");
                //uint256 testx2;
                listOfNormalAddresse_main = listOfNormalAdds(block.timestamp);
                //testx2 = listOfNormalAdds(currentTime);
                console.log("After getting list of normals");
                //showlistofNormals(listOfNormalAddresses);
                console.log("divideprice = ", dividedPrice);
                console.log(
                    "listOfNormalAddresse_main = ",
                    listOfNormalAddresse_main.length
                );
                lastAnswer = transferFunds(
                    dividedPrice,
                    listOfNormalAddresse_main
                );
                console.log("The transactions done successfully");
                console.log("Here is the accounts get their reward");
            }
        }
    }

    function showlistofNormals(address[] normalTests) public view {
        uint256 ltest = normalTests.length;
        for (ltest; ltest > normalTests.length; ltest--) {
            console.log(normalTests[ltest]);
        }
    }

    function countNormals(uint256 _timeRequested_countNormal)
        public
        returns (uint256)
    {
        uint256 x_countNormal = 0;
        uint256 i_countNormal = 0;
        uint256[] timesArray_count_normal2;
        uint256[] lookingTimes_count_normal2;
        // uint256 testtime = _timeRequested;
        // uint256 x;
        // i = normalCounter;
        newTime = _timeRequested_countNormal - 20000;

        for (i_countNormal; i_countNormal < normalCounter; i_countNormal++) {
            timesArray_count_normal2.push(
                NormalDriverMap[i_countNormal].reqTime
            );
            console.log(
                "timesarray[0] = ",
                NormalDriverMap[i_countNormal].reqTime
            );
        }
        z_count_normal = timesArray_count_normal2.length;
        console.log("z_count_number = ", z_count_normal);
        temp_count_normal = 0;
        while (temp_count_normal < z_count_normal) {
            if (timesArray_count_normal2[temp_count_normal] > newTime) {
                lookingTimes_count_normal2.push(
                    timesArray_count_normal2[temp_count_normal]
                );
            }

            temp_count_normal = temp_count_normal + 1;
        }

        x_countNormal = lookingTimes_count_normal2.length;
        console.log("number of normals from countNormals =", x_countNormal);
        //delete timesArray_count_normal;
        //delete lookingTimes_count_normal;
        return x_countNormal;
    }

    /*
             for (_timeRequested; _timeRequested >= newt; _timeRequested--){
                            //uint lengthTimes;
                            // lengthTimes = timesArray.length;
                            //uint[] memory times = new uint[](lengthTimes);
                           // console.log("z after loop", testtime);
                            
                            if (timesArray[z] == _timeRequested){
                             lookingTimes.push(_timeRequested);
                             console.log("ok");
                             }
                             z = z-1;
                             console.log("z before if",z);
                             if (z==0){
                                 x= lookingTimes.length;
                                 return x;
                                 //revert("z==0");
                             }
                             
             }

        
            */

    //console.log("number of normals",x);

    function listOfNormalAdds(uint256 _timelna)
        public
        returns (address[] memory)
    {
        uint256 z_lna;
        uint256 newTime_lna;
        uint256 lna_counter = 0;
        uint256 temp_lna;
        address[] NormalAddressesArray_lna2;
        uint256[] timesArray_lna2;
        address[] lookingAddress_lna2;
        //delete lookingAddress_lna;
        //   uint256 x2;
        // lna_counter = normalCounter;
        // console.log("i before for", i);
        newTime_lna = _timelna - 20000;
        //uint[] memory times = new uint[]();
        for (lna_counter; lna_counter < normalCounter; lna_counter++) {
            NormalAddressesArray_lna2.push(
                NormalDriverMap[lna_counter].waletAddress
            );
            console.log(
                "NormalAddressesArray_lna2[] = ",
                NormalAddressesArray_lna2[lna_counter]
            );
            timesArray_lna2.push(NormalDriverMap[lna_counter].reqTime);
            console.log("timesArray_lna2[] = ", timesArray_lna2[lna_counter]);
        }
        z_lna = NormalAddressesArray_lna2.length;
        console.log("zlna = ", z_lna);
        temp_lna = 0;

        while (temp_lna < z_lna) {
            if (timesArray_lna2[temp_lna] > newTime_lna) {
                lookingAddress_lna2.push(NormalAddressesArray_lna2[temp_lna]);
                //     console.log("inside if",timesArray[temp]);
                //console.log("temp = ",temp);
                console.log(
                    "NormalAddressesArray_lna2[temp_lna] =",
                    NormalAddressesArray_lna2[temp_lna]
                );
            }
            // console.log("temp = ",temp);

            temp_lna = temp_lna + 1;
        }
        //uint256 testx;
        // testx= lookingAddress_lna.length;
        // console.log("inside lna");
        // delete timesArray_lna;
        //delete lookingAddress_lna;
        return lookingAddress_lna2;
    }

    function transferfundTest(uint256 moneyTest, address addTest)
        public
        payable
        returns (bool)
    {
        addTest.transfer(moneyTest);
        return true;
    }

    function transferFunds(uint256 _fund, address[] memory _addressesPay)
        public
        payable
        returns (bool)
    {
        //  address [] addressesToPay;
        //  addressesToPay =memory(_addressesPay);
        uint256 l;
        l = _addressesPay.length;
        console.log("addressPay length = ", l);
        for (uint256 c = 0; c < l; c++) {
            _addressesPay[c].transfer(_fund);
            console.log(_addressesPay[c]);
        }
        delete _addressesPay;

        // _addressesPay[0].transfer(1000000000000000 wei);
        return true;
    }

    function countPreviousNOs() public returns (uint256) {
        /*
            1- add the arguments to the 'Fast' list
            2-  count requests come in the <= 'X' seconds from the 'Ns' list
            3- if (counts == 0){
                print (you can go in free)
                }
                else{
                        1- call the 'calculate the price' function & receive the price
                        2- ask the user to see if he/she wants to pay or not and receive the answer.
                        3- if ('NO'){
                                print('you cannot enter')
                    
                        }
                        4- if('YES'){
                                1- get the ETH.
                                2- call the function 'count the Normals' and receive the numbers and their address.
                                3- divide the ETH to the number received and transfer it to them

                        }

                }
        */
    }

    function calcuPaymentAmount(uint256 _time) public returns (uint256) {
        ///////////////////////////////// for the fasts ////////////////////////

        uint256 numberOfFasts;
        uint256 f = fastCounter;
        // console.log("i before for", i);
        newTime3 = _time - 20000;
        //uint[] memory times = new uint[]();
        for (f; f > 0; f--) {
            fastAddressArray.push(FastDriverMap[f].waletAddress);
            timesArray2.push(NormalDriverMap[i].reqTime);
        }
        z3 = fastAddressArray.length;
        temp = 0;
        while (temp < z3) {
            if (timesArray2[temp] > newTime3) {
                lookingAddress.push(NormalAddressesArray[temp]);
                //     console.log("inside if",timesArray[temp]);
                //console.log("temp = ",temp);
            }
            // console.log("temp = ",temp);

            temp = temp + 1;
        }

        numberOfFasts = lookingAddress.length;

        delete lookingAddress;
        timesArray2.length = 0;
        temp = 0;

        // TO DO
        // TEST THE DELETES

        ////////////////////////////////////////////////////////////////////
        // for the normals
        uint256 z2;
        uint256 newTime2;
        uint256 numberOfNormals;
        i = normalCounter;
        // console.log("i before for", i);
        newTime2 = _time - 20000;
        //uint[] memory times = new uint[]();
        for (i; i > 0; i--) {
            NormalAddressesArray.push(NormalDriverMap[i].waletAddress);
            timesArray2.push(NormalDriverMap[i].reqTime);
        }
        z2 = NormalAddressesArray.length;

        temp = 0;

        while (temp < z2) {
            if (timesArray2[temp] > newTime2) {
                lookingAddress.push(NormalAddressesArray[temp]);
                //     console.log("inside if",timesArray[temp]);
                //console.log("temp = ",temp);
            }
            // console.log("temp = ",temp);

            temp = temp + 1;
        }

        numberOfNormals = lookingAddress.length;
        delete lookingAddress;
        timesArray2.length = 0;
        temp = 0;

        // TO DO
        // TEST THE DELETES

        //////////////////// capacity fast //////////////////////
        uint256 capacityFast;
        uint256 velocityFast = 100; //kmph
        uint256 avgLengthCars = 4; //meter
        uint256 sFast; //Average of center to center spacing of vehicles.
        sFast = ((2 * velocityFast) / 10) + avgLengthCars;
        capacityFast = 1000 * (velocityFast / sFast);

        //////////////////// capacity normal //////////////////
        uint256 capacityNormal;
        uint256 velocityNormal = 90; //kmph
        //  uint256 avgLengthCars = 4; //meter
        uint256 sNormal; //Average of center to center spacing of vehicles.
        sNormal = ((2 * velocityNormal) / 10) + avgLengthCars;
        capacityNormal = (1000 * (velocityNormal / sNormal)) * 2;
        /*
            calculate the max capacity
            count the fast list if it is more than max ==>> price * 2
            count the normal lane if it was more than twice the traffic ==>> price * 0.75
        */

        if (numberOfFasts > capacityFast) {
            recentPrice = recentPrice * 2;
        }
        if (numberOfNormals > capacityNormal) {
            recentPrice = (recentPrice * 75) / 100;
        }
        console.log("recent price = ", recentPrice);
        // uint256 usdP = getConversionRate(recentPrice);

        // console.log("USD price = ", usdP);

        return recentPrice;
    }

    function showBalance() public view returns (uint256) {
        return this.balance;
    }

    function AskToPay(uint256 _p, address _tp)
        public
        payable
        returns (uint256)
    {
        return AddressToFundsReceived[msg.sender] += msg.value;
        // return address(this).balance;

        /*
        
        1- call the function that calculate the amount.
        2- ask to pay if returns true then accept the eth 
        
        if (False){
            print ('you cannot enter')
            
        }
        else{
        
        3- then count requests come in the <= 'X' seconds from the 'Ns' list
        
        4- divide the ETH to that number.
        
        5- transfer it to the founded addresses
        
        }
        */
    }
    /*
        mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function fund() public payable {
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
         return uint256(answer * 10000000000);
    }
    
    // 1000000000
    function getConversionRate(uint256 ethAmount ) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) ;
        return ethAmountInUsd;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function withdraw() payable onlyOwner public {
        msg.sender.transfer(address(this).balance);
        
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
    */
}
