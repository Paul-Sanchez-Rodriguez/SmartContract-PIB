// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*
* @title Contrato de Acuerdo para contratar a un empleado
* @dev Este contrato es una demostracion de como tengo pensado hacer mi smart Contract
*/
contract ContratoDeTrabajo {

    /*
    * @dev este struct tiene todos los valores que registrare y mostrare
    */

    struct Empleado {
        address contratista;
        address trabajador;
        uint256 salarioMensual;
        uint256 fechaInicio;
        uint256 fechaFin;
        bool contratoActivo;
    }

    mapping(address => Empleado) private empleados;

    /*
    * @dev en el contructor se ingresaran 3 parametros
    * @param trabajadorNew es el nuevo trabajador
    * @param salarioMensualNew es el salario que se le pagara mensual
    * @param fechaFinNew es la fecha que finalizara el contrato
    */

    constructor(
        address trabajadorNew,
        uint256 salarioMensualNew,
        uint256 fechaFinNew
    ) {

        empleados[trabajadorNew] = Empleado({
            contratista : msg.sender,
            trabajador: trabajadorNew,
            salarioMensual: salarioMensualNew,
            fechaInicio: block.timestamp,
            fechaFin: fechaFinNew,
            contratoActivo: true
        });
    }

    /**
    * @dev este modificador valida que el address sea valido
    */
    modifier validAddress(address addr){
        require(addr != address(0), "address invalido");
        _;
    }


    /*
    * @dev Esta funcion realiza la extencion del contrato del empleado
    * @param Recibe dos paramentros, la fecha a la que se extendera y a que empleado se le extendera el contrato
    */
    function extenderContrato(uint256 nuevaFechaFin , address empleado) validAddress(empleado) public payable{
        empleados[empleado].fechaFin = nuevaFechaFin;
    }


    /*
    * @dev Esta funcion Finaliza la funcion que se creado
    * @param el parametro es el address del empleado a quien se va a cancelar el contrato
    */
    function TerminarContrato(address empleado) validAddress(empleado) public payable{
        require(empleados[empleado].contratoActivo == true, "El contrato ya esta desabilitado");
        empleados[empleado].contratoActivo = false;
    }

    /*
    * @dev Esta funcion busca al empleado por su address
    * @param tiene un parametro, donde se ingresa el address del empleado que se esta buscando
    * @return el empleado que se ha buscado y se ha encontrado
    */
    function verDatosEmpleado(address empleado) public view returns (
        address contratista,
        address trabajador,
        uint256 salarioMensual,
        uint256 fechaInicio,
        uint256 fechaFin,
        bool contratoActivo
    ) {
        Empleado storage empleadoActual = empleados[empleado];

        return (
            empleadoActual.contratista,
            empleadoActual.trabajador,
            empleadoActual.salarioMensual,
            empleadoActual.fechaInicio,
            empleadoActual.fechaFin,
            empleadoActual.contratoActivo
        );
    }

    receive() external payable {}

    fallback() external payable {}

}
