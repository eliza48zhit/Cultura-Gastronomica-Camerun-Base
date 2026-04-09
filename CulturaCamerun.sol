// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaCamerun
 * @dev Registro de procesos de desamargado y envoltorios termicos naturales.
 * Serie: Sabores de Africa (10/54)
 */
contract CulturaCamerun {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 intensidadLavado; // Escala de reduccion de amargor (1-10)
        bool usaEnvoltorioHoja;   // Uso de hojas de platano o Marantaceae
        bool fermentacionPrevia;  // Para derivados de la yuca como el Bobolo
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Ndole (El alma de Camerun)
        registrarPlato(
            "Ndole", 
            "Hojas de Ndole, cacahuetes frescos, carne, camarones secos.",
            "Lavar las hojas repetidamente para reducir amargor, cocer con pasta de mani.",
            8, 
            false, 
            false
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _lavado, 
        bool _hoja,
        bool _fermentacion
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_lavado <= 10, "Escala lavado: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            intensidadLavado: _lavado,
            usaEnvoltorioHoja: _hoja,
            fermentacionPrevia: _fermentacion,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 lavado,
        bool hoja,
        bool fermentacion,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.intensidadLavado, p.usaEnvoltorioHoja, p.fermentacionPrevia, p.likes);
    }
}
