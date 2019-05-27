//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        let favorite = UIBarButtonItem(image: #imageLiteral(resourceName: "whitestar"), style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = favorite
        print(recipe)
    }

    @objc func favoriteTapped() {
        //add favorite
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-minuteur-50"), style: .plain,
                                                                 target: self, action: #selector(favoriteTapped))
    }
}
