//
//  RecipeResume.swift
//  Reciplease
//
//  Created by Kévin Courtois on 27/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class RecipeResume: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    //Initalisation of the xib
    func commonInit() {
        //Load xib by name
        let contentView = Bundle.main.loadNibNamed(selfName(), owner: self, options: nil)?.first as? UIView ?? UIView()
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }

    //Get class name and turn it to a string
    private func selfName() -> String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
}
