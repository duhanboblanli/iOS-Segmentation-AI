import Foundation

//MARK: - Localize
extension String{
    func localizedCropper() -> String{
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
