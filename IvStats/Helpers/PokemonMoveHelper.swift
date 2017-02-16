//
//  PokemonMoveHelper.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-13.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import UIKit

struct PokemonMoveDetail {
    var pokemonMove: PokemonMove
    var moveType: PokemonType
    var dps: Double
    var damage: Double
}

class PokemonMoveHelper
{
    static var pokemonMoveDetailDictionary: [PokemonMove: PokemonMoveDetail] =
        [.pound: PokemonMoveDetail.init(pokemonMove: .pound, moveType: .pokemonTypeNormal, dps: 13, damage: 7),
         .poundFast: PokemonMoveDetail.init(pokemonMove: .poundFast, moveType: .pokemonTypeNormal, dps: 13, damage: 7),
         .scratch: PokemonMoveDetail.init(pokemonMove: .scratch, moveType: .pokemonTypeNormal, dps: 12, damage: 6),
         .scratchFast: PokemonMoveDetail.init(pokemonMove: .scratchFast, moveType: .pokemonTypeNormal, dps: 12, damage: 6),
         .tackle: PokemonMoveDetail.init(pokemonMove: .tackle, moveType: .pokemonTypeNormal, dps: 10.9, damage: 12),
         .tackleFast: PokemonMoveDetail.init(pokemonMove: .tackleFast, moveType: .pokemonTypeNormal, dps: 10.9, damage: 12),
         .cut: PokemonMoveDetail.init(pokemonMove: .cut, moveType: .pokemonTypeNormal, dps: 10.6, damage: 12),
         .cutFast: PokemonMoveDetail.init(pokemonMove: .cutFast, moveType: .pokemonTypeNormal, dps: 10.6, damage: 12),
         .quickAttack: PokemonMoveDetail.init(pokemonMove: .quickAttack, moveType: .pokemonTypeNormal, dps: 7.5, damage: 10),
         .quickAttackFast: PokemonMoveDetail.init(pokemonMove: .quickAttackFast, moveType: .pokemonTypeNormal, dps: 7.5, damage: 10),
         .transformFast: PokemonMoveDetail.init(pokemonMove: .transformFast, moveType: .pokemonTypeNormal, dps: 0, damage: 0),
         .hyperBeam: PokemonMoveDetail.init(pokemonMove: .hyperBeam, moveType: .pokemonTypeNormal, dps: 21.8, damage: 120),
         .bodySlam: PokemonMoveDetail.init(pokemonMove: .bodySlam, moveType: .pokemonTypeNormal, dps: 19.4, damage: 40),
         .hyperFang: PokemonMoveDetail.init(pokemonMove: .hyperFang, moveType: .pokemonTypeNormal, dps: 13.5, damage: 35),
         .stomp: PokemonMoveDetail.init(pokemonMove: .stomp, moveType: .pokemonTypeNormal, dps: 11.5, damage: 30),
         .viceGrip: PokemonMoveDetail.init(pokemonMove: .viceGrip, moveType: .pokemonTypeNormal, dps: 11.5, damage: 30),
         .hornAttack: PokemonMoveDetail.init(pokemonMove: .hornAttack, moveType: .pokemonTypeNormal, dps: 9.3, damage: 25),
         .swift: PokemonMoveDetail.init(pokemonMove: .swift, moveType: .pokemonTypeNormal, dps: 8.6, damage: 30),
         .struggle: PokemonMoveDetail.init(pokemonMove: .struggle, moveType: .pokemonTypeNormal, dps: 6.8, damage: 15),
         .wrap: PokemonMoveDetail.init(pokemonMove: .wrap, moveType: .pokemonTypeNormal, dps: 5.6, damage: 25),
         .rockSmashFast: PokemonMoveDetail.init(pokemonMove: .rockSmashFast, moveType: .pokemonTypeFighting, dps: 10.6, damage: 15),
         .lowKick: PokemonMoveDetail.init(pokemonMove: .lowKick, moveType: .pokemonTypeFighting, dps: 8.3, damage: 5),
         .lowKickFast: PokemonMoveDetail.init(pokemonMove: .lowKickFast, moveType: .pokemonTypeFighting, dps: 8.3, damage: 5),
         .karateChop: PokemonMoveDetail.init(pokemonMove: .karateChop, moveType: .pokemonTypeFighting, dps: 7.5, damage: 6),
         .karateChopFast: PokemonMoveDetail.init(pokemonMove: .karateChopFast, moveType: .pokemonTypeFighting, dps: 7.5, damage: 6),
         .crossChop: PokemonMoveDetail.init(pokemonMove: .crossChop, moveType: .pokemonTypeFighting, dps: 24, damage: 60),
         .brickBreak: PokemonMoveDetail.init(pokemonMove: .brickBreak, moveType: .pokemonTypeFighting, dps: 14.3, damage: 30),
         .submission: PokemonMoveDetail.init(pokemonMove: .submission, moveType: .pokemonTypeFighting, dps: 11.5, damage: 30),
         .lowSweep: PokemonMoveDetail.init(pokemonMove: .lowSweep, moveType: .pokemonTypeFighting, dps: 10.9, damage: 30),
         .wingAttack: PokemonMoveDetail.init(pokemonMove: .wingAttack, moveType: .pokemonTypeFlying, dps: 12, damage: 9),
         .wingAttackFast: PokemonMoveDetail.init(pokemonMove: .wingAttackFast, moveType: .pokemonTypeFlying, dps: 12, damage: 9),
         .peck: PokemonMoveDetail.init(pokemonMove: .peck, moveType: .pokemonTypeFlying, dps: 8.7, damage: 10),
         .peckFast: PokemonMoveDetail.init(pokemonMove: .peckFast, moveType: .pokemonTypeFlying, dps: 8.7, damage: 10),
         .hurricane: PokemonMoveDetail.init(pokemonMove: .hurricane, moveType: .pokemonTypeFlying, dps: 21.6, damage: 80),
         .drillPeck: PokemonMoveDetail.init(pokemonMove: .drillPeck, moveType: .pokemonTypeFlying, dps: 12.5, damage: 40),
         .aerialAce: PokemonMoveDetail.init(pokemonMove: .aerialAce, moveType: .pokemonTypeFlying, dps: 8.8, damage: 30),
         .airCutter: PokemonMoveDetail.init(pokemonMove: .airCutter, moveType: .pokemonTypeFlying, dps: 7.9, damage: 30),
         .poisonJab: PokemonMoveDetail.init(pokemonMove: .poisonJab, moveType: .pokemonTypePoison, dps: 11.4, damage: 12),
         .poisonJabFast: PokemonMoveDetail.init(pokemonMove: .poisonJabFast, moveType: .pokemonTypePoison, dps: 11.4, damage: 12),
         .poisonStingFast: PokemonMoveDetail.init(pokemonMove: .poisonStingFast, moveType: .pokemonTypePoison, dps: 10.4, damage: 6),
         .acid: PokemonMoveDetail.init(pokemonMove: .acid, moveType: .pokemonTypePoison, dps: 9.5, damage: 10),
         .acidFast: PokemonMoveDetail.init(pokemonMove: .acidFast, moveType: .pokemonTypePoison, dps: 9.5, damage: 10),
         .gunkShot: PokemonMoveDetail.init(pokemonMove: .gunkShot, moveType: .pokemonTypePoison, dps: 18.6, damage: 65),
         .sludgeWave: PokemonMoveDetail.init(pokemonMove: .sludgeWave, moveType: .pokemonTypePoison, dps: 17.9, damage: 70),
         .sludgeBomb: PokemonMoveDetail.init(pokemonMove: .sludgeBomb, moveType: .pokemonTypePoison, dps: 17.7, damage: 12.5),
         .crossPoison: PokemonMoveDetail.init(pokemonMove: .crossPoison, moveType: .pokemonTypePoison, dps: 12.5, damage: 25),
         .sludge: PokemonMoveDetail.init(pokemonMove: .sludge, moveType: .pokemonTypePoison, dps: 9.7, damage: 30),
         .poisonFang: PokemonMoveDetail.init(pokemonMove: .poisonFang, moveType: .pokemonTypePoison, dps: 8.6, damage: 25),
         .mudSlapFast: PokemonMoveDetail.init(pokemonMove: .mudSlapFast, moveType: .pokemonTypeGround, dps: 11.1, damage: 15),
         .mudShot: PokemonMoveDetail.init(pokemonMove: .mudShot, moveType: .pokemonTypeGround, dps: 10.9, damage: 6),
         .mudShotFast: PokemonMoveDetail.init(pokemonMove: .mudShotFast, moveType: .pokemonTypeGround, dps: 10.9, damage: 6),
         .earthquake: PokemonMoveDetail.init(pokemonMove: .earthquake, moveType: .pokemonTypeGround, dps: 21.3, damage: 100),
         .drillRun: PokemonMoveDetail.init(pokemonMove: .drillRun, moveType: .pokemonTypeGround, dps: 12.8, damage: 50),
         .boneClub: PokemonMoveDetail.init(pokemonMove: .boneClub, moveType: .pokemonTypeGround, dps: 11.9, damage: 25),
         .dig: PokemonMoveDetail.init(pokemonMove: .dig, moveType: .pokemonTypeGround, dps: 11.1, damage: 70),
         .mudBomb: PokemonMoveDetail.init(pokemonMove: .mudBomb, moveType: .pokemonTypeGround, dps: 9.7, damage: 30),
         .bulldoze: PokemonMoveDetail.init(pokemonMove: .bulldoze, moveType: .pokemonTypeGround, dps: 9, damage: 35),
         .rockThrow: PokemonMoveDetail.init(pokemonMove: .rockThrow, moveType: .pokemonTypeRock, dps: 8.8, damage: 12),
         .rockThrowFast: PokemonMoveDetail.init(pokemonMove: .rockThrowFast, moveType: .pokemonTypeRock, dps: 8.8, damage: 12),
         .stoneEdge: PokemonMoveDetail.init(pokemonMove: .stoneEdge, moveType: .pokemonTypeRock, dps: 22.2, damage: 80),
         .rockSlide: PokemonMoveDetail.init(pokemonMove: .rockSlide, moveType: .pokemonTypeRock, dps: 13.5, damage: 50),
         .powerGem: PokemonMoveDetail.init(pokemonMove: .powerGem, moveType: .pokemonTypeRock, dps: 11.8, damage: 40),
         .ancientPower: PokemonMoveDetail.init(pokemonMove: .ancientPower, moveType: .pokemonTypeRock, dps: 8.5, damage: 35),
         .rockTomb: PokemonMoveDetail.init(pokemonMove: .rockTomb, moveType: .pokemonTypeRock, dps: 7.7, damage: 30),
         .bugBite: PokemonMoveDetail.init(pokemonMove: .bugBite, moveType: .pokemonTypeBug, dps: 11.1, damage: 5),
         .bugBiteFast: PokemonMoveDetail.init(pokemonMove: .bugBiteFast, moveType: .pokemonTypeBug, dps: 11.1, damage: 5),
         .furyCutter: PokemonMoveDetail.init(pokemonMove: .furyCutter, moveType: .pokemonTypeBug, dps: 7.5, damage: 3),
         .furyCutterFast: PokemonMoveDetail.init(pokemonMove: .furyCutterFast, moveType: .pokemonTypeBug, dps: 7.5, damage: 3),
         .megahorn: PokemonMoveDetail.init(pokemonMove: .megahorn, moveType: .pokemonTypeBug, dps: 21.6, damage: 80),
         .bugBuzz: PokemonMoveDetail.init(pokemonMove: .bugBuzz, moveType: .pokemonTypeBug, dps: 15.8, damage: 75),
         .xScissor: PokemonMoveDetail.init(pokemonMove: .xScissor, moveType: .pokemonTypeBug, dps: 13.5, damage: 35),
         .signalBeam: PokemonMoveDetail.init(pokemonMove: .signalBeam, moveType: .pokemonTypeBug, dps: 12.5, damage: 45),
         .shadowClaw: PokemonMoveDetail.init(pokemonMove: .shadowClaw, moveType: .pokemonTypeGhost, dps: 11.6, damage: 11),
         .shadowClawFast: PokemonMoveDetail.init(pokemonMove: .shadowClawFast, moveType: .pokemonTypeGhost, dps: 11.6, damage: 11),
         .lick: PokemonMoveDetail.init(pokemonMove: .lick, moveType: .pokemonTypeGhost, dps: 10, damage: 5),
         .lickFast: PokemonMoveDetail.init(pokemonMove: .lickFast, moveType: .pokemonTypeGhost, dps: 10, damage: 5),
         .shadowBall: PokemonMoveDetail.init(pokemonMove: .shadowBall, moveType: .pokemonTypeGhost, dps: 12.6, damage: 45),
         .ominousWind: PokemonMoveDetail.init(pokemonMove: .ominousWind, moveType: .pokemonTypeGhost, dps: 8.3, damage: 30),
         .metalClaw: PokemonMoveDetail.init(pokemonMove: .metalClaw, moveType: .pokemonTypeSteel, dps: 12.7, damage: 8),
         .metalClawFast: PokemonMoveDetail.init(pokemonMove: .metalClawFast, moveType: .pokemonTypeSteel, dps: 12.7, damage: 8),
         .steelWing: PokemonMoveDetail.init(pokemonMove: .steelWing, moveType: .pokemonTypeSteel, dps: 11.3, damage: 15),
         .steelWingFast: PokemonMoveDetail.init(pokemonMove: .steelWingFast, moveType: .pokemonTypeSteel, dps: 11.3, damage: 15),
         .bulletPunch: PokemonMoveDetail.init(pokemonMove: .bulletPunch, moveType: .pokemonTypeSteel, dps: 8.3, damage: 10),
         .bulletPunchFast: PokemonMoveDetail.init(pokemonMove: .bulletPunchFast, moveType: .pokemonTypeSteel, dps: 8.3, damage: 10),
         .flashCannon: PokemonMoveDetail.init(pokemonMove: .flashCannon, moveType: .pokemonTypeSteel, dps: 13.6, damage: 60),
         .ironHead: PokemonMoveDetail.init(pokemonMove: .ironHead, moveType: .pokemonTypeSteel, dps: 12, damage: 30),
         .magnetBomb: PokemonMoveDetail.init(pokemonMove: .magnetBomb, moveType: .pokemonTypeSteel, dps: 9.1, damage: 30),
         .fireFangFast: PokemonMoveDetail.init(pokemonMove: .fireFangFast, moveType: .pokemonTypeFire, dps: 11.9, damage: 10),
         .ember:
            PokemonMoveDetail.init(pokemonMove: .ember, moveType: .pokemonTypeFire, dps: 9.5, damage: 10),
         .emberFast:
            PokemonMoveDetail.init(pokemonMove: .emberFast, moveType: .pokemonTypeFire, dps: 9.5, damage: 10),
         .fireBlast:
            PokemonMoveDetail.init(pokemonMove: .fireBlast, moveType: .pokemonTypeFire, dps: 21.7, damage: 100),
         .heatWave:
            PokemonMoveDetail.init(pokemonMove: .heatWave, moveType: .pokemonTypeFire, dps: 18.6, damage: 80),
         .flamethrower:
            PokemonMoveDetail.init(pokemonMove: .flamethrower, moveType: .pokemonTypeFire, dps: 16.2, damage: 55),
         .firePunch:
            PokemonMoveDetail.init(pokemonMove: .firePunch, moveType: .pokemonTypeFire, dps: 12.1, damage: 40),
         .flameBurst:
            PokemonMoveDetail.init(pokemonMove: .flameBurst, moveType: .pokemonTypeFire, dps: 11.5, damage: 30),
         .flameWheel:
            PokemonMoveDetail.init(pokemonMove: .flameWheel, moveType: .pokemonTypeFire, dps: 7.8, damage: 40),
         .flameCharge:
            PokemonMoveDetail.init(pokemonMove: .flameCharge, moveType: .pokemonTypeFire, dps: 6.9, damage: 25),
         .waterGun: PokemonMoveDetail.init(pokemonMove: .waterGun, moveType: .pokemonTypeWater, dps: 12, damage: 6),
         .waterGunFast: PokemonMoveDetail.init(pokemonMove: .waterGunFast, moveType: .pokemonTypeWater, dps: 12, damage: 6),
         .bubbleFast: PokemonMoveDetail.init(pokemonMove: .bubbleFast, moveType: .pokemonTypeWater, dps: 10.9, damage: 25),
         .splash: PokemonMoveDetail.init(pokemonMove: .splash, moveType: .pokemonTypeWater, dps: 0, damage: 0),
         .splashFast: PokemonMoveDetail.init(pokemonMove: .splashFast, moveType: .pokemonTypeWater, dps: 0, damage: 0),
         .hydroPump: PokemonMoveDetail.init(pokemonMove: .hydroPump, moveType: .pokemonTypeWater, dps: 20.9, damage: 90),
         .aquaTail: PokemonMoveDetail.init(pokemonMove: .aquaTail, moveType: .pokemonTypeWater, dps: 15.8, damage: 45),
         .scald: PokemonMoveDetail.init(pokemonMove: .scald, moveType: .pokemonTypeWater, dps: 12.2, damage: 55),
         .waterPulse: PokemonMoveDetail.init(pokemonMove: .waterPulse, moveType: .pokemonTypeWater, dps: 9.2, damage: 35),
         .bubbleBeam: PokemonMoveDetail.init(pokemonMove: .bubbleBeam, moveType: .pokemonTypeWater, dps: 8.8, damage: 30),
         .aquaJet: PokemonMoveDetail.init(pokemonMove: .aquaJet, moveType: .pokemonTypeWater, dps: 8.8, damage: 25),
         .brine: PokemonMoveDetail.init(pokemonMove: .brine, moveType: .pokemonTypeWater, dps: 8.6, damage: 25),
         .vineWhip: PokemonMoveDetail.init(pokemonMove: .vineWhip, moveType: .pokemonTypeGrass, dps: 10.8, damage: 7),
         .vineWhipFast: PokemonMoveDetail.init(pokemonMove: .vineWhipFast, moveType: .pokemonTypeGrass, dps: 10.8, damage: 7),
         .razorLeaf: PokemonMoveDetail.init(pokemonMove: .razorLeaf, moveType: .pokemonTypeGrass, dps: 10.3, damage: 15),
         .razorLeafFast: PokemonMoveDetail.init(pokemonMove: .razorLeafFast, moveType: .pokemonTypeGrass, dps: 10.3, damage: 15),
         .solarBeam: PokemonMoveDetail.init(pokemonMove: .solarBeam, moveType: .pokemonTypeGrass, dps: 22.2, damage: 120),
         .powerWhip: PokemonMoveDetail.init(pokemonMove: .powerWhip, moveType: .pokemonTypeGrass, dps: 21.2, damage: 70),
         .petalBlizzard: PokemonMoveDetail.init(pokemonMove: .petalBlizzard, moveType: .pokemonTypeGrass, dps: 17.6, damage: 65),
         .leafBlade: PokemonMoveDetail.init(pokemonMove: .leafBlade, moveType: .pokemonTypeGrass, dps: 16.7, damage: 55),
         .seedBomb: PokemonMoveDetail.init(pokemonMove: .seedBomb, moveType: .pokemonTypeGrass, dps: 13.8, damage: 40),
         .spark: PokemonMoveDetail.init(pokemonMove: .spark, moveType: .pokemonTypeElectric, dps: 10, damage: 7),
         .sparkFast: PokemonMoveDetail.init(pokemonMove: .sparkFast, moveType: .pokemonTypeElectric, dps: 10, damage: 7),
         .thunderShock: PokemonMoveDetail.init(pokemonMove: .thunderShock, moveType: .pokemonTypeElectric, dps: 8.3, damage: 5),
         .thunderShockFast: PokemonMoveDetail.init(pokemonMove: .thunderShockFast, moveType: .pokemonTypeElectric, dps: 8.3, damage: 5),
         .thunder: PokemonMoveDetail.init(pokemonMove: .thunder, moveType: .pokemonTypeElectric, dps: 20.8, damage: 100),
         .thunderbolt: PokemonMoveDetail.init(pokemonMove: .thunderbolt, moveType: .pokemonTypeElectric, dps: 17.2, damage: 55),
         .thunderPunch: PokemonMoveDetail.init(pokemonMove: .thunderPunch, moveType: .pokemonTypeElectric, dps: 13.8, damage: 40),
         .discharge: PokemonMoveDetail.init(pokemonMove: .discharge, moveType: .pokemonTypeElectric, dps: 11.7, damage: 35),
         .psychoCut: PokemonMoveDetail.init(pokemonMove: .psychoCut, moveType: .pokemonTypePsychic, dps: 12.3, damage: 7),
         .psychoCutFast: PokemonMoveDetail.init(pokemonMove: .psychoCutFast, moveType: .pokemonTypePsychic, dps: 12.3, damage: 7),
         .zenHeadbuttFast: PokemonMoveDetail.init(pokemonMove: .zenHeadbuttFast, moveType: .pokemonTypePsychic, dps: 11.4, damage: 12),
         .confusionFast: PokemonMoveDetail.init(pokemonMove: .confusionFast, moveType: .pokemonTypePsychic, dps: 9.9, damage: 15),
         .psychic: PokemonMoveDetail.init(pokemonMove: .psychic, moveType: .pokemonTypePsychic, dps: 16.7, damage: 55),
         .psybeam: PokemonMoveDetail.init(pokemonMove: .psybeam, moveType: .pokemonTypePsychic, dps: 9.3, damage: 40),
         .psyshock: PokemonMoveDetail.init(pokemonMove: .psyshock, moveType: .pokemonTypePsychic, dps: 12.5, damage: 40),
         .frostBreath: PokemonMoveDetail.init(pokemonMove: .frostBreath, moveType: .pokemonTypeIce, dps: 11.1, damage: 9),
         .frostBreathFast: PokemonMoveDetail.init(pokemonMove: .frostBreathFast, moveType: .pokemonTypeIce, dps: 11.1, damage: 9),
         .iceShard: PokemonMoveDetail.init(pokemonMove: .iceShard, moveType: .pokemonTypeIce, dps: 107.7, damage: 15),
         .iceShardFast: PokemonMoveDetail.init(pokemonMove: .iceShardFast, moveType: .pokemonTypeIce, dps: 10.7, damage: 15),
         .blizzard: PokemonMoveDetail.init(pokemonMove: .blizzard, moveType: .pokemonTypeIce, dps: 22.7, damage: 100),
         .iceBeam: PokemonMoveDetail.init(pokemonMove: .iceBeam, moveType: .pokemonTypeIce, dps: 15.7, damage: 65),
         .icePunch: PokemonMoveDetail.init(pokemonMove: .icePunch, moveType: .pokemonTypeIce, dps: 11.3, damage: 45),
         .icyWind: PokemonMoveDetail.init(pokemonMove: .icyWind, moveType: .pokemonTypeIce, dps: 5.8, damage: 25),
         .dragonBreath: PokemonMoveDetail.init(pokemonMove: .dragonBreath, moveType: .pokemonTypeDragon, dps: 12, damage: 6),
         .dragonBreathFast: PokemonMoveDetail.init(pokemonMove: .dragonBreathFast, moveType: .pokemonTypeDragon, dps: 12, damage: 6),
         .dragonClaw: PokemonMoveDetail.init(pokemonMove: .dragonClaw, moveType: .pokemonTypeDragon, dps: 17.5, damage: 35),
         .dragonPulse: PokemonMoveDetail.init(pokemonMove: .dragonPulse, moveType: .pokemonTypeDragon, dps: 15.9, damage: 65),
         .twister: PokemonMoveDetail.init(pokemonMove: .twister, moveType: .pokemonTypeDragon, dps: 7.8, damage: 25),
         .bite: PokemonMoveDetail.init(pokemonMove: .bite, moveType: .pokemonTypeDark, dps: 12, damage: 6),
         .biteFast: PokemonMoveDetail.init(pokemonMove: .biteFast, moveType: .pokemonTypeDark, dps: 12, damage: 6),
         .feintAttackFast: PokemonMoveDetail.init(pokemonMove: .feintAttackFast, moveType: .pokemonTypeDark, dps: 11.5, damage: 12),
         .suckerPunch: PokemonMoveDetail.init(pokemonMove: .suckerPunch, moveType: .pokemonTypeDark, dps: 10, damage: 7),
         .suckerPunchFast: PokemonMoveDetail.init(pokemonMove: .suckerPunchFast, moveType: .pokemonTypeDark, dps: 10, damage: 7),
         .darkPulse: PokemonMoveDetail.init(pokemonMove: .darkPulse, moveType: .pokemonTypeDark, dps: 11.3, damage: 45),
         .nightSlash: PokemonMoveDetail.init(pokemonMove: .nightSlash, moveType: .pokemonTypeDark, dps: 9.4, damage: 30),
         .moonblast: PokemonMoveDetail.init(pokemonMove: .moonblast, moveType: .pokemonTypeFairy, dps: 18.5, damage: 85),
         .playRough: PokemonMoveDetail.init(pokemonMove: .playRough, moveType: .pokemonTypeFairy, dps: 16.2, damage: 55),
         .dazzlingGleam: PokemonMoveDetail.init(pokemonMove: .dazzlingGleam, moveType: .pokemonTypeFairy, dps: 11.7, damage: 55),
         .drainingKiss: PokemonMoveDetail.init(pokemonMove: .drainingKiss, moveType: .pokemonTypeFairy, dps: 7.6, damage: 25),
         .disarmingVoice: PokemonMoveDetail.init(pokemonMove: .disarmingVoice, moveType: .pokemonTypeFairy, dps: 5.7, damage: 25),
         .moveUnset: PokemonMoveDetail.init(pokemonMove: .moveUnset, moveType: .pokemonTypeNone, dps: 0, damage: 0)]
    
    
    class func getMoveDisplayName(forMove move: PokemonMove) -> String
    {
        var name = move.toString()
        name = name.replacingOccurrences(of: "_FAST", with: "")
        name = name.replacingOccurrences(of: "_", with: " ")
        name = name.lowercased()
        name = name.capitalized
        return name
    }
    
    class func getMoveTypeColor(forMove move: PokemonMove) -> UIColor
    {
        if let foundMove = pokemonMoveDetailDictionary[move]
        {
            return PokemonHelper.getTypeColor(withPokemonType: foundMove.moveType)
        }
        else
        {
            return PokemonHelper.getTypeColor(withPokemonType: PokemonType.pokemonTypeNone)
        }
    }
    
    class func getMoveType(forMove move: PokemonMove) -> PokemonType
    {
        if let foundMove = pokemonMoveDetailDictionary[move]
        {
            return foundMove.moveType
        }
        else
        {
            return PokemonType.pokemonTypeNone
        }
    }
    
    class func getMoveDPS(forMove move: PokemonMove) -> Double
    {
        if let foundMove = pokemonMoveDetailDictionary[move]
        {
            return foundMove.dps
        }
        else
        {
            return 0
        }
    }
    
    class func getMoveDamage(forMove move: PokemonMove) -> Double
    {
        if let foundMove = pokemonMoveDetailDictionary[move]
        {
            return foundMove.damage
        }
        else
        {
            return 0
        }
    }
}
