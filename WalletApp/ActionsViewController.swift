//
//  ActionsViewController.swift
//  WalletApp
//
//  Created by Мах Ol on 15.03.2023.
//

import UIKit
import UniqueSDK

class ActionsViewController: UIViewController {
    
    
    let account = Unique.Account.loadAccounts().first!
    let buildParameters = UNQRequestParameters(withFee: nil, verify: nil, callbackUrl: nil, nonce: nil)
    var extrinsicHash: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var buildResponse: UNQUnsignedTxPayloadResponse?
    
    @IBAction func buildCollectionAction(_ sender: Any) {
        let body = UNQCreateColletionBody(mode: .nft,
                                          name: "SomeName",
                                          description: "SomeDescription",
                                          tokenPrefix: "SomeTokenPrefix",
                                          sponsorship: nil,
                                          limits: nil,
                                          metaUpdatePermission: nil,
                                          permissions: nil,
                                          readOnly: false,
                                          address: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo",
                                          schema: nil,
                                          properties: nil,
                                          tokenPropertyPermissions: nil)
        Task {
            do {
                let result = try await Unique.Collection.creation.build(parameters: buildParameters, body: body)
                buildResponse = result
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    var signResponse: UNQSignResponse?
    
    @IBAction func signCollectionAction(_ sender: Any) {
        guard let buildResponse = buildResponse else { return }
        Task {
            do {
                let result = try await Unique.Collection.creation.sign(parameters: buildParameters,
                                                                       body: buildResponse,
                                                                       account: account,
                                                                       userAuthenticationType: .biometric)
                signResponse = result
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func submitCollectionAction(_ sender: Any) {
        guard let signResponse = signResponse else { return }
        let buildParameters = UNQRequestParameters(withFee: nil, verify: nil, callbackUrl: nil, nonce: nil)
        let body = UNQSubmitTxBody(signerPayloadJSON: signResponse.signerPayloadJSON, signature: signResponse.signature)
        Task {
            do {
                let result = try await Unique.Collection.creation.submitWatch(parameters: buildParameters,
                                                                              body: body,
                                                                              account: account,
                                                                              userAuthenticationType: .biometric)
                extrinsicHash = result.hash
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    
    
    @IBAction func createCollectionAction(_ sender: Any) {
        let body = UNQCreateColletionBody(mode: .nft,
                                          name: "Name",
                                          description: "Description",
                                          tokenPrefix: "TokenPrefix",
                                          sponsorship: nil,
                                          limits: nil,
                                          metaUpdatePermission: nil,
                                          permissions: nil,
                                          readOnly: false,
                                          address: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo",
                                          schema: nil,
                                          properties: nil,
                                          tokenPropertyPermissions: nil)
        Task {
            do {
                let result = try await Unique.Collection.creation.submitWatch(parameters: buildParameters,
                                                                              body: body,
                                                                              account: account,
                                                                              userAuthenticationType: .biometric)
                extrinsicHash = result.hash
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func createTokenAction(_ sender: Any) {
        let body = UNQCreateTokenBody(owner: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo", data: nil, properties: nil, address: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo", collectionId: 948)
        Task {
            do {
                let result = try await Unique.Token.create.submitWatch(parameters: buildParameters,
                                                                       body: body,
                                                                       account: account,
                                                                       userAuthenticationType: .biometric)
                extrinsicHash = result.hash
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    
    var cid: String = ""
    
    @IBAction func uploadCollectionImageAction(_ sender: Any) {
        guard let image = UIImage(named: "Monkeys"), let data = image.jpegData(compressionQuality: 0.5) else { return }
        let file = UNQFormData(fileName: "Monkeys", mimeType: "jpg", data: data)
        Task {
            do {
                let result = try await Unique.Ipfs.uploadFile(file: file)
                cid = result.cid
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func createCollectionWithImageAction(_ sender: Any) {
        let coverPicture = UNQCoverPicture(urlInfix: cid, url: nil, ipfcCid: nil, hash: nil)
        let schemaImage = UNQCollectionSchemaImage(urlTemplate: "https://ipfs.unique.network/ipfs/{infix}")
        let schema = UNQCollectionSchemaToCreate(attributesSchema: nil,
                                                 attributesSchemaVersion: nil,
                                                 coverPicture: coverPicture,
                                                 image: schemaImage,
                                                 schemaName: .unique,
                                                 schemaVersion: "1.0.0",
                                                 coverPicturePreview: nil,
                                                 imagePreview: nil,
                                                 audio: nil,
                                                 spatialObject: nil,
                                                 video: nil)
        let body = UNQCreateColletionBody(mode: .nft,
                                          name: "Monkeys Collection",
                                          description: "Description",
                                          tokenPrefix: "Monkey",
                                          sponsorship: nil,
                                          limits: nil,
                                          metaUpdatePermission: nil,
                                          permissions: nil,
                                          readOnly: false,
                                          address: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo",
                                          schema: schema,
                                          properties: nil,
                                          tokenPropertyPermissions: nil)
        Task {
            do {
                let result = try await Unique.Collection.creation.submitWatch(parameters: buildParameters,
                                                                              body: body,
                                                                              account: account,
                                                                              userAuthenticationType: .biometric)
                extrinsicHash = result.hash
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func uploadTokenImageAction(_ sender: Any) {
        guard let image = UIImage(named: "Monkey2"), let data = image.jpegData(compressionQuality: 0.5) else { return }
        let file = UNQFormData(fileName: "Monkey2", mimeType: "jpg", data: data)
        Task {
            do {
                let result = try await Unique.Ipfs.uploadFile(file: file)
                cid = result.cid
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func createTokenWithImageAction(_ sender: Any) {
        let image = UNQEncodedInfixOrUrlOrCidAndHash(urlInfix: cid, url: nil, ipfsCid: nil, hash: nil)
        let data = UNQTokenToCreateDto(image: image,
                                       attributes: nil,
                                       encodedAttributes: nil,
                                       name: nil,
                                       audio: nil,
                                       description: nil,
                                       imagePreview: nil,
                                       spatialObject: nil,
                                       video: nil)
        let body = UNQCreateTokenBody(owner: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo", data: data, properties: nil, address: "5HEK4aJcrzw1M7cqvXDzGBUVcUEAsCACJ6Jyn4P56R3DyJEo", collectionId: 947)
        Task {
            do {
                let result = try await Unique.Token.create.submitWatch(parameters: buildParameters,
                                                                       body: body,
                                                                       account: account,
                                                                       userAuthenticationType: .biometric)
                extrinsicHash = result.hash
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func checkExtrinsicAction(_ sender: Any) {
        Task {
            do {
                let result = try await Unique.Extrinsic.status(hash: extrinsicHash)
                let parsedData = result.parsed?.value
                
                if let dictionary = parsedData as? [String : Int] {
                    let collectionId = dictionary["collectionId"]
                    let tokenId = dictionary["tokenId"]
                    
                    print(collectionId)
                    print(tokenId)
                }
            } catch (let error) {
                print(error)
            }
        }
        
    }
}
