// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleElection{
    address admin = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bool electionStarted = false;

    function startElection() public {
        require(msg.sender == admin, "Only Admin Can Perform This Action");
        electionStarted = true;
    }
    
    function stopElection() public {
        require(msg.sender == admin, "Only Admin Can Perform This Action");
        electionStarted = false;
    }

    struct Candidate{
        uint256 id;
        string name;
        uint256 voteCount;
    }

    Candidate[]public candidates;

    constructor(){
        candidates.push(Candidate(0,"A",0));
        candidates.push(Candidate(1,"B",0));
        candidates.push(Candidate(2,"C",0));
        candidates.push(Candidate(3,"D",0));
        candidates.push(Candidate(4,"E",0));
    }

    mapping (address=>bool) internal voted;

    function vote(uint256 id) public {
        require(id < candidates.length, "Invalid Candidate Id");
        require(voted[msg.sender] == false,"You have already Voted");
        require(electionStarted,"Election is not started");
        candidates[id].voteCount++;
        voted[msg.sender] = true;
    }

    function winnerCheck()public view returns(Candidate memory){
        Candidate memory winner = candidates[0];
        for (uint256 i = 1; i < candidates.length; i++) 
        {
            if (winner.voteCount < candidates[i].voteCount){
                winner = candidates[i];
            }        
        }
        return winner;
    }

}
