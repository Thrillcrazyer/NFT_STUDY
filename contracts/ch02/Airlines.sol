pragma solidity ^0.8.7;

contract Airlines{

    address chairperson;
    struct details{
        uint escrow;
        uint status;
        uint hashOfDetails;
    }

// 항공사 어카운트 페이먼트와 회원매핑
    mapping (address => details) public balanceDetails;
    mapping (address => uint) membership;

// modifier => 생성자들(require 문을 분해한거랑 비슷한 느낌)
    modifier onlyChairperson{
        require(msg.sender==chairperson);
        _;
    }

    modifier onnlyMember{
        require(membership[msg.sender] == 1);
        _;
    }

// 생성자 함수
    constructor() public payable{

        chairperson= msg.sender;
        membership[msg.sender]=1;
        balanceDetails[msg.sender].escrow=msg.value;
    }

    function register() public payable{
        address AirlineA= msg.sender;
        membership[AirlineA]=1;
        balanceDetails[msg.sender].escrow= msg.value;
    }

    function unregister(address payable AirlineZ) onlyChairperson public{
        membership[AirlineZ]=0;
        //출발 항공사에게 에스크로를 반환;다른 조건들 확인
        AirlineZ.transfer(balanceDetails[AirlineZ].escrow);
        balanceDetails[AirlineZ].escrow =0;
    }

    function request(address toAirline, uint hashOfDetails) onnlyMember public{
        if(membership[toAirline]!= 1){
            revert();
        }
        balanceDetails[msg.sender].status= 0;
        balanceDetails[toAirline].hashOfDetails = hashOfDetails;
    }


    function response(address fromAirline, uint hashOfDetails, uint done) onnlyMember public{
        if(membership[fromAirline]!= 1){
            revert();
        }
        balanceDetails[msg.sender].status= done;
        balanceDetails[fromAirline].hashOfDetails = hashOfDetails;
    }

    function settlePayment (address payable toAirline) onnlyMember payable public{
        address fromAirline=msg.sender;
        uint amt = msg.value;

        balanceDetails[toAirline].escrow = balanceDetails[toAirline].escrow+amt;
        balanceDetails[fromAirline].escrow = balanceDetails[fromAirline].escrow-amt;
        // msg.sender로 부터 amt를 차감해 toAirline에게 보냄
        toAirline.transfer(amt);
    }

}