pragma solidity 0.8.7;


// 데이터 아이템들

contract BallotV1{

    struct Voter{
        uint weight;
        bool voted;
        uint vote;
    }

    struct Proposal{
        uint voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    enum Phase {Init, Regs, Vote, Done}

    Phase public state = Phase.Done;

    modifier validPhase(Phase reqPhase){
        require(state== reqPhase);
        _;
    }


    constructor (unit numProposals) public{
        onlyChairperson = msg.sender;
        voters[chairperson].weight=2;
        for (uint prop=0;prop<numProposals;prop++){
            proposals.push(Proposal(0));
        }
    }

    function changeState(Phase x)public{
        if(msg.sender != chairperson) revert();
        if(x <state) revert();
        state=x;
    }

    function register(address voter) public validPhase(Phase.Vote){

        Voter memory sender = voters[msg.sender];
        if(sender.voted|| )
    }

}