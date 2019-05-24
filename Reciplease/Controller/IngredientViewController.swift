//
//  ViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let rserv = RecipeService()
        rserv.search(searchText: "chicken") { (_, _) in
            //
        }
    }
}
