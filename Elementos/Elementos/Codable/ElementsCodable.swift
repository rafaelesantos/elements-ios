//
//  ElementsCodable.swift
//  Elementos
//
//  Created by Rafael Escaleira on 24/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public struct ElementsCodable: Codable {
    
    var appearance: String?
    var atomic_mass: Double?
    var boil: Double?
    var category: String?
    var color: String?
    var density: Double?
    var discovered_by: String?
    var electron_affinity: Double?
    var electron_configuration: String?
    var electronegativity_pauling: Double?
    var ionization_energies: [Double]?
    var melt: Double?
    var molar_heat: Double?
    var name: String?
    var named_by: String?
    var number: Int?
    var period: Int?
    var phase: String?
    var shells: [Int]?
    var source: String?
    var spectral_img: String?
    var summary: String?
    var symbol: String?
    var xpos: Int?
    var ypos: Int?

    enum CodingKeys: String, CodingKey {

        case appearance = "appearance"
        case atomic_mass = "atomic_mass"
        case boil = "boil"
        case category = "category"
        case color = "color"
        case density = "density"
        case discovered_by = "discovered_by"
        case electron_affinity = "electron_affinity"
        case electron_configuration = "electron_configuration"
        case electronegativity_pauling = "electronegativity_pauling"
        case ionization_energies = "ionization_energies"
        case melt = "melt"
        case molar_heat = "molar_heat"
        case name = "name"
        case named_by = "named_by"
        case number = "number"
        case period = "period"
        case phase = "phase"
        case shells = "shells"
        case source = "source"
        case spectral_img = "spectral_img"
        case summary = "summary"
        case symbol = "symbol"
        case xpos = "xpos"
        case ypos = "ypos"
    }

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        appearance = try values.decodeIfPresent(String.self, forKey: .appearance)
        atomic_mass = try values.decodeIfPresent(Double.self, forKey: .atomic_mass)
        boil = try values.decodeIfPresent(Double.self, forKey: .boil)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        density = try values.decodeIfPresent(Double.self, forKey: .density)
        discovered_by = try values.decodeIfPresent(String.self, forKey: .discovered_by)
        electron_affinity = try values.decodeIfPresent(Double.self, forKey: .electron_affinity)
        electron_configuration = try values.decodeIfPresent(String.self, forKey: .electron_configuration)
        electronegativity_pauling = try values.decodeIfPresent(Double.self, forKey: .electronegativity_pauling)
        ionization_energies = try values.decodeIfPresent([Double].self, forKey: .ionization_energies)
        melt = try values.decodeIfPresent(Double.self, forKey: .melt)
        molar_heat = try values.decodeIfPresent(Double.self, forKey: .molar_heat)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        named_by = try values.decodeIfPresent(String.self, forKey: .named_by)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        period = try values.decodeIfPresent(Int.self, forKey: .period)
        phase = try values.decodeIfPresent(String.self, forKey: .phase)
        shells = try values.decodeIfPresent([Int].self, forKey: .shells)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        spectral_img = try values.decodeIfPresent(String.self, forKey: .spectral_img)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        xpos = try values.decodeIfPresent(Int.self, forKey: .xpos)
        ypos = try values.decodeIfPresent(Int.self, forKey: .ypos)
    }
}
