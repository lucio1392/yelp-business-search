//
//  KingFisher+ext.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import RxCocoa
import RxSwift
import Kingfisher

extension KingfisherWrapper {
    public struct Rx {
        private let wrapper: KingfisherWrapper<KFCrossPlatformImageView>
        
        init(_ base: KingfisherWrapper<KFCrossPlatformImageView>) {
            self.wrapper = base
        }

        public func image(placeholder: Placeholder? = nil,
                          options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
            // `base.base` is the `Kingfisher` class' associated `ImageView`.
            return Binder(wrapper.base) { imageView, image in
                imageView.kf.setImage(with: image,
                                      placeholder: placeholder,
                                      options: options)
            }
        }
    }
}

public extension KingfisherWrapper where Base == KFCrossPlatformImageView {
    var rx: KingfisherWrapper.Rx {
        .init(self)
    }
}
