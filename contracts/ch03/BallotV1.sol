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

}