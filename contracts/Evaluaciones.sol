// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

pragma experimental ABIEncoderV2;



contract Evaluaciones {
    address public profesor;

    constructor(){
        profesor = msg.sender;
    }


    mapping (bytes32 => uint) public Notas;

    string [] public revisiones;

    event alumnoEvaluado (bytes32);
    event eventoRevision (string);


    modifier UnicoProfesor (address _direccion){
        require(_direccion == profesor, "no sos el prfesorrrrr");
        _;

    }

    function evaluar(string memory _idAlumno, uint _nota)public UnicoProfesor(msg.sender) {
        bytes32 hash_alumno = keccak256(abi.encodePacked(_idAlumno));
        Notas[hash_alumno] = _nota;

        emit alumnoEvaluado(hash_alumno);

    }



    function verNotas(string memory _idAlumno ) public view returns(uint){
        bytes32 hash_alumno = keccak256(abi.encodePacked(_idAlumno));
        uint notas_alumno = Notas[hash_alumno];
        return notas_alumno ;
    }



    function Revision (string memory _idAlumno) public {
        revisiones.push(_idAlumno);
        emit eventoRevision(_idAlumno);
    }

    function VerRevisiones () public view UnicoProfesor(msg.sender) returns(string [] memory){
        return revisiones;
    }
 


}