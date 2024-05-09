//
//  PratosModel.swift
//  Pirarucool
//
//  Created by Guilherme Ferreira Lenzolari on 26/04/24.
//

import Foundation

struct Prato: Codable, Hashable {
    let id: Int
    let nomeDoPrato: String
    let preço: Int
    let imagemPrincipal: String
    let imagensSecundárias: [String]
    let categoria: String
    let quantasPessoasServe: Int
    let descriçãoDoPrato: String
    let ingredientes, alérgicos: [String]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nomeDoPrato = "Nome do prato"
        case preço = "Preço"
        case imagemPrincipal = "Imagem principal"
        case imagensSecundárias = "Imagens secundárias"
        case categoria = "Categoria"
        case quantasPessoasServe = "Quantas Pessoas serve"
        case descriçãoDoPrato = "Descrição do prato"
        case ingredientes = "Ingredientes"
        case alérgicos = "Alérgicos"
    }
}
