//
//  ViewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/7/30.
//

import UIKit

enum PalmL10n {
    static func text(_ key: String) -> String {
        NSLocalizedString(key, tableName: "PalmGuide", bundle: .main, value: key, comment: "")
    }

    static func format(_ key: String, _ arguments: CVarArg...) -> String {
        String(format: text(key), locale: Locale.current, arguments: arguments)
    }
}

struct PalmVariant {
    let lineID: String
    let index: Int

    var title: String { PalmL10n.text("line.\(lineID).variant.\(index).title") }
    var meaning: String { PalmL10n.text("line.\(lineID).variant.\(index).meaning") }
    var observation: String { PalmL10n.text("line.\(lineID).variant.\(index).observation") }
}

struct PalmLine {
    let id: String
    let assetName: String
    let variantCount: Int
    let atlasCount: Int

    var title: String { PalmL10n.text("line.\(id).title") }
    var subtitle: String { PalmL10n.text("line.\(id).subtitle") }
    var summary: String { PalmL10n.text("line.\(id).summary") }
    var observation: String { PalmL10n.text("line.\(id).observation") }
    var traditionalMeaning: String { PalmL10n.text("line.\(id).traditional_meaning") }
    var confusionNote: String { PalmL10n.text("line.\(id).confusion") }
    var tags: [String] { PalmL10n.text("line.\(id).tags").components(separatedBy: "|") }
    var variants: [PalmVariant] {
        (1...variantCount).map { PalmVariant(lineID: id, index: $0) }
    }
}

struct PalmPathStep {
    let index: Int

    var title: String { PalmL10n.text("path.step.\(index).title") }
    var action: String { PalmL10n.text("path.step.\(index).action") }
    var detail: String { PalmL10n.text("path.step.\(index).detail") }
}

struct PalmLessonDay {
    let index: Int
    let itemIDs: [String]

    var title: String { PalmL10n.text("learn.day.\(index).title") }
    var subtitle: String { PalmL10n.text("learn.day.\(index).subtitle") }
    var goal: String { PalmL10n.text("learn.day.\(index).goal") }
    var practice: String { PalmL10n.text("learn.day.\(index).practice") }
    var items: [PalmGalleryItem] { itemIDs.compactMap(PalmistryRepository.galleryItem(withID:)) }
}

struct PalmTabSpec {
    let id: String
    let titleKey: String
    let symbolName: String
}

struct PalmCompassSection {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let detailKey: String
    let symbolName: String
    let accent: UIColor

    var title: String { PalmL10n.text(titleKey) }
    var subtitle: String { PalmL10n.text(subtitleKey) }
    var detail: String { PalmL10n.text(detailKey) }
}

struct PalmQuestionPath {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let focusKey: String
    let symbolName: String
    let accent: UIColor

    var title: String { PalmL10n.text(titleKey) }
    var subtitle: String { PalmL10n.text(subtitleKey) }
    var focus: String { PalmL10n.text(focusKey) }
}

struct PalmLearningModule {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let symbolName: String
    let accent: UIColor

    var title: String { PalmL10n.text(titleKey) }
    var subtitle: String { PalmL10n.text(subtitleKey) }
}

struct PalmLibraryCategory {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let itemCount: Int
    let symbolName: String

    var title: String { PalmL10n.text(titleKey) }
    var subtitle: String { PalmL10n.text(subtitleKey) }
}

struct PalmAtlasCategory {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let assetName: String

    var title: String { PalmL10n.text(titleKey) }
    var subtitle: String { PalmL10n.text(subtitleKey) }
}

struct PalmGalleryItem {
    let id: String
    let lineID: String
    let index: Int
    let assetName: String
    let titleText: String
    let subtitleText: String
    let positionText: String
    let observationText: String
    let traditionalReadingText: String
    let modernReadingText: String
    let misreadText: String
    let judgementText: String
    let actionAdviceText: String
    let disclaimerText: String

    var title: String { titleText }
    var subtitle: String { subtitleText }
    var position: String { positionText }
    var observation: String { observationText }
    var traditionalReading: String { traditionalReadingText }
    var modernReading: String { modernReadingText }
    var misread: String { misreadText }
    var judgement: String { judgementText }
    var actionAdvice: String { actionAdviceText }
    var disclaimer: String { disclaimerText }
}

enum PalmistryRepository {
    static let tabSpecs: [PalmTabSpec] = [
        PalmTabSpec(id: "atlas", titleKey: "tab.atlas", symbolName: "house"),
        PalmTabSpec(id: "gallery", titleKey: "tab.gallery", symbolName: "square.grid.2x2"),
        PalmTabSpec(id: "path", titleKey: "tab.path", symbolName: "map"),
        PalmTabSpec(id: "mine", titleKey: "tab.mine", symbolName: "person")
    ]

    static let lines: [PalmLine] = [
        PalmLine(id: "life", assetName: "p5100", variantCount: 4, atlasCount: 52),
        PalmLine(id: "head", assetName: "p5200", variantCount: 4, atlasCount: 58),
        PalmLine(id: "heart", assetName: "p5300", variantCount: 4, atlasCount: 44),
        PalmLine(id: "career", assetName: "p5400", variantCount: 4, atlasCount: 46),
        PalmLine(id: "marriage", assetName: "p5500", variantCount: 4, atlasCount: 39),
        PalmLine(id: "sun", assetName: "p5600", variantCount: 4, atlasCount: 31)
    ]

    static var totalAtlasCount: Int {
        lines.reduce(0) { $0 + $1.atlasCount }
    }

    static let compassSections: [PalmCompassSection] = [
        PalmCompassSection(id: "lines", titleKey: "compass.lines.title", subtitleKey: "compass.lines.subtitle", detailKey: "compass.lines.detail", symbolName: "hand.draw", accent: PalmTheme.green),
        PalmCompassSection(id: "mounts", titleKey: "compass.mounts.title", subtitleKey: "compass.mounts.subtitle", detailKey: "compass.mounts.detail", symbolName: "circle.hexagongrid", accent: PalmTheme.ochre),
        PalmCompassSection(id: "signs", titleKey: "compass.signs.title", subtitleKey: "compass.signs.subtitle", detailKey: "compass.signs.detail", symbolName: "sparkles", accent: PalmTheme.wine),
        PalmCompassSection(id: "rhythm", titleKey: "compass.rhythm.title", subtitleKey: "compass.rhythm.subtitle", detailKey: "compass.rhythm.detail", symbolName: "waveform.path.ecg", accent: PalmTheme.rose)
    ]

    static let questionPaths: [PalmQuestionPath] = [
        PalmQuestionPath(id: "love", titleKey: "ask.love.title", subtitleKey: "ask.love.subtitle", focusKey: "ask.love.focus", symbolName: "heart", accent: PalmTheme.wine),
        PalmQuestionPath(id: "thinking", titleKey: "ask.thinking.title", subtitleKey: "ask.thinking.subtitle", focusKey: "ask.thinking.focus", symbolName: "brain.head.profile", accent: PalmTheme.green),
        PalmQuestionPath(id: "action", titleKey: "ask.action.title", subtitleKey: "ask.action.subtitle", focusKey: "ask.action.focus", symbolName: "briefcase", accent: PalmTheme.ochre),
        PalmQuestionPath(id: "rhythm", titleKey: "ask.rhythm.title", subtitleKey: "ask.rhythm.subtitle", focusKey: "ask.rhythm.focus", symbolName: "leaf", accent: PalmTheme.rose)
    ]

    static let learningModules: [PalmLearningModule] = [
        PalmLearningModule(id: "seven-day", titleKey: "learn.seven_day.title", subtitleKey: "learn.seven_day.subtitle", symbolName: "calendar", accent: PalmTheme.green),
        PalmLearningModule(id: "library", titleKey: "learn.library.title", subtitleKey: "learn.library.subtitle", symbolName: "books.vertical", accent: PalmTheme.wine)
    ]

    static let libraryCategories: [PalmLibraryCategory] = [
        PalmLibraryCategory(id: "lines", titleKey: "library.category.lines.title", subtitleKey: "library.category.lines.subtitle", itemCount: 270, symbolName: "hand.draw"),
        PalmLibraryCategory(id: "mounts", titleKey: "library.category.mounts.title", subtitleKey: "library.category.mounts.subtitle", itemCount: 32, symbolName: "circle.hexagongrid"),
        PalmLibraryCategory(id: "signs", titleKey: "library.category.signs.title", subtitleKey: "library.category.signs.subtitle", itemCount: 48, symbolName: "sparkles"),
        PalmLibraryCategory(id: "questions", titleKey: "library.category.questions.title", subtitleKey: "library.category.questions.subtitle", itemCount: 24, symbolName: "questionmark.bubble")
    ]

    static let atlasCategories: [PalmAtlasCategory] = [
        PalmAtlasCategory(id: "lines", titleKey: "atlas.category.lines.title", subtitleKey: "atlas.category.lines.subtitle", assetName: "liudaxianwen"),
        PalmAtlasCategory(id: "mounts", titleKey: "atlas.category.mounts.title", subtitleKey: "atlas.category.mounts.subtitle", assetName: "badazhangqiu"),
        PalmAtlasCategory(id: "palaces", titleKey: "atlas.category.palaces.title", subtitleKey: "atlas.category.palaces.subtitle", assetName: "bagong"),
        PalmAtlasCategory(id: "basics", titleKey: "atlas.category.basics.title", subtitleKey: "atlas.category.basics.subtitle", assetName: "jibenshouxiang"),
        PalmAtlasCategory(id: "tutorial", titleKey: "atlas.category.tutorial.title", subtitleKey: "atlas.category.tutorial.subtitle", assetName: "shouxiangjiaocheng"),
        PalmAtlasCategory(id: "rhythm", titleKey: "atlas.category.rhythm.title", subtitleKey: "atlas.category.rhythm.subtitle", assetName: "jiankang01")
    ]

    static func lineGalleryItems(for lineID: String) -> [PalmGalleryItem] {
        generatedGalleryItems.filter { $0.lineID == lineID }.sorted { $0.index < $1.index }
    }

    static func galleryItem(withID id: String) -> PalmGalleryItem? {
        generatedGalleryItems.first { $0.id == id }
    }

    static let pathSteps: [PalmPathStep] = [
        PalmPathStep(index: 1),
        PalmPathStep(index: 2),
        PalmPathStep(index: 3),
        PalmPathStep(index: 4)
    ]

    static let lessonDays: [PalmLessonDay] = [
        PalmLessonDay(index: 1, itemIDs: ["life-0", "head-0", "heart-0"]),
        PalmLessonDay(index: 2, itemIDs: ["life-1", "life-2", "life-19"]),
        PalmLessonDay(index: 3, itemIDs: ["head-1", "head-2", "head-20"]),
        PalmLessonDay(index: 4, itemIDs: ["heart-1", "heart-20", "heart-38"]),
        PalmLessonDay(index: 5, itemIDs: ["career-0", "career-12", "career-30"]),
        PalmLessonDay(index: 6, itemIDs: ["marriage-0", "marriage-23", "marriage-24"]),
        PalmLessonDay(index: 7, itemIDs: ["sun-0", "career-0", "heart-0"])
    ]

    static let planItemKeys = [
        "plan.item.1",
        "plan.item.2",
        "plan.item.3",
        "plan.item.4",
        "plan.item.5"
    ]

    static func line(withID id: String) -> PalmLine? {
        lines.first { $0.id == id }
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

enum PalmTheme {
    static let background = UIColor(red: 0.982, green: 0.976, blue: 0.949, alpha: 1)
    static let surface = UIColor.white.withAlphaComponent(0.92)
    static let ink = UIColor(red: 0.112, green: 0.212, blue: 0.184, alpha: 1)
    static let muted = UIColor(red: 0.412, green: 0.482, blue: 0.451, alpha: 1)
    static let border = UIColor(red: 0.846, green: 0.878, blue: 0.862, alpha: 1)
    static let green = UIColor(red: 0.137, green: 0.431, blue: 0.353, alpha: 1)
    static let wine = UIColor(red: 0.561, green: 0.361, blue: 0.514, alpha: 1)
    static let ochre = UIColor(red: 0.745, green: 0.506, blue: 0.192, alpha: 1)
    static let rose = UIColor(red: 0.725, green: 0.302, blue: 0.259, alpha: 1)

    static func roundedFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(.rounded)
        return UIFont(descriptor: descriptor ?? UIFontDescriptor(), size: size)
    }
}

enum PalmImageStore {
    static func image(named name: String) -> UIImage? {
        if let image = UIImage(named: name) {
            return image
        }
        let bundle = Bundle(for: ViewController.self)
        if let pngPath = bundle.path(forResource: name, ofType: "png"),
           let image = UIImage(contentsOfFile: pngPath) {
            return image
        }
        if let jpgPath = bundle.path(forResource: name, ofType: "jpg"),
           let image = UIImage(contentsOfFile: jpgPath) {
            return image
        }
        return nil
    }
}

private extension UIView {
    func addPinnedSubview(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        ])
    }
}

private extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment = .fill) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
}

private class PalmGradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor]) {
        super.init(frame: .zero)
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

private class PalmScrollViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView(axis: .vertical, spacing: 20)
    var prefersNavigationBarHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PalmTheme.background
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addPinnedSubview(scrollView)
        scrollView.addPinnedSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(prefersNavigationBarHidden, animated: animated)
    }
}

private final class PalmImagePanel: UIView {
    let imageView = UIImageView()

    init(imageName: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.76)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowRadius = 18
        layer.shadowOffset = CGSize(width: 0, height: 10)

        imageView.image = PalmImageStore.image(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        addPinnedSubview(imageView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.92).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(imageName: String) {
        UIView.transition(with: imageView, duration: 0.24, options: .transitionCrossDissolve) {
            self.imageView.image = PalmImageStore.image(named: imageName)
        }
    }
}

private final class PalmHeaderView: UIView {
    init(title: String, subtitle: String, symbolName: String) {
        super.init(frame: .zero)

        let titleLabel = UILabel()
        titleLabel.font = PalmTheme.roundedFont(size: 38, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.text = title
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.76

        let subtitleLabel = UILabel()
        subtitleLabel.font = PalmTheme.roundedFont(size: 18, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.text = subtitle

        let textStack = UIStackView(axis: .vertical, spacing: 6)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        let iconView = UIImageView(image: UIImage(systemName: symbolName))
        iconView.tintColor = PalmTheme.ink
        iconView.contentMode = .center
        iconView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        iconView.layer.cornerRadius = 30
        iconView.layer.borderWidth = 1
        iconView.layer.borderColor = PalmTheme.border.cgColor
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let row = UIStackView(axis: .horizontal, spacing: 16, alignment: .center)
        row.addArrangedSubview(textStack)
        row.addArrangedSubview(iconView)
        addPinnedSubview(row)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class PalmLineChip: UIButton {
    let lineID: String

    init(line: PalmLine) {
        self.lineID = line.id
        super.init(frame: .zero)
        setTitle(line.title, for: .normal)
        titleLabel?.font = PalmTheme.roundedFont(size: 17, weight: .semibold)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        updateSelection(false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSelection(_ selected: Bool) {
        isSelected = selected
        backgroundColor = selected ? PalmTheme.wine : UIColor.white.withAlphaComponent(0.86)
        layer.borderColor = selected ? PalmTheme.wine.cgColor : PalmTheme.border.cgColor
        setTitleColor(selected ? .white : PalmTheme.ink, for: .normal)
    }
}

private final class PalmLineSummaryView: PalmGradientView {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let tagStack = UIStackView(axis: .horizontal, spacing: 8)
    var onOpen: (() -> Void)?

    init() {
        super.init(colors: [PalmTheme.wine, UIColor(red: 0.154, green: 0.235, blue: 0.217, alpha: 1)])
        layer.cornerRadius = 8
        clipsToBounds = true

        titleLabel.font = PalmTheme.roundedFont(size: 28, weight: .bold)
        titleLabel.textColor = .white
        bodyLabel.font = PalmTheme.roundedFont(size: 17, weight: .regular)
        bodyLabel.textColor = UIColor.white.withAlphaComponent(0.84)
        bodyLabel.numberOfLines = 0

        tagStack.distribution = .fillProportionally

        let button = UIButton(type: .system)
        button.setTitle(PalmL10n.text("summary.open_topic"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .white
        button.backgroundColor = PalmTheme.green
        button.layer.cornerRadius = 8
        button.titleLabel?.font = PalmTheme.roundedFont(size: 19, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        button.addTarget(self, action: #selector(openTapped), for: .touchUpInside)

        let stack = UIStackView(axis: .vertical, spacing: 16)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(bodyLabel)
        stack.addArrangedSubview(tagStack)
        stack.addArrangedSubview(button)
        addPinnedSubview(stack, insets: UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(line: PalmLine) {
        titleLabel.text = line.title
        bodyLabel.text = line.summary
        tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        line.tags.forEach { tag in
            let label = UILabel()
            label.text = tag
            label.textColor = UIColor.white.withAlphaComponent(0.92)
            label.textAlignment = .center
            label.font = PalmTheme.roundedFont(size: 14, weight: .medium)
            label.layer.cornerRadius = 15
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.white.withAlphaComponent(0.22).cgColor
            label.clipsToBounds = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            tagStack.addArrangedSubview(label)
        }
    }

    @objc private func openTapped() {
        onOpen?()
    }
}

private final class PalmInfoSectionView: UIView {
    init(title: String, body: String, accent: UIColor = PalmTheme.rose) {
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor

        let stripe = UIView()
        stripe.backgroundColor = accent
        stripe.layer.cornerRadius = 2
        stripe.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = PalmTheme.roundedFont(size: 17, weight: .bold)
        titleLabel.textColor = PalmTheme.ink

        let bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.font = PalmTheme.roundedFont(size: 16, weight: .regular)
        bodyLabel.textColor = PalmTheme.muted
        bodyLabel.numberOfLines = 0
        bodyLabel.lineBreakMode = .byWordWrapping

        let stack = UIStackView(axis: .vertical, spacing: 8)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(bodyLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stripe)
        addSubview(stack)
        NSLayoutConstraint.activate([
            stripe.leadingAnchor.constraint(equalTo: leadingAnchor),
            stripe.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stripe.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stripe.widthAnchor.constraint(equalToConstant: 3),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class PalmLineRowView: UIButton {
    private let previewImageView = UIImageView()
    private let lineTitleLabel = UILabel()
    private let lineSubtitleLabel = UILabel()
    private let summaryLabel = UILabel()
    let line: PalmLine

    init(line: PalmLine) {
        self.line = line
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityLabel = line.title
        accessibilityIdentifier = "atlas.line.\(line.id)"
        accessibilityHint = PalmL10n.format("accessibility.open_line_topic_format", line.title)

        previewImageView.image = PalmImageStore.image(named: line.assetName)
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.clipsToBounds = true
        previewImageView.layer.cornerRadius = 6
        previewImageView.isUserInteractionEnabled = false
        previewImageView.widthAnchor.constraint(equalToConstant: 92).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: 92).isActive = true

        lineTitleLabel.text = line.title
        lineTitleLabel.font = PalmTheme.roundedFont(size: 22, weight: .bold)
        lineTitleLabel.textColor = PalmTheme.ink
        lineTitleLabel.isUserInteractionEnabled = false

        lineSubtitleLabel.text = PalmL10n.format("line.atlas_count_format", line.subtitle, line.atlasCount)
        lineSubtitleLabel.font = PalmTheme.roundedFont(size: 14, weight: .medium)
        lineSubtitleLabel.textColor = PalmTheme.wine
        lineSubtitleLabel.isUserInteractionEnabled = false

        summaryLabel.text = line.summary
        summaryLabel.font = PalmTheme.roundedFont(size: 15, weight: .regular)
        summaryLabel.textColor = PalmTheme.muted
        summaryLabel.numberOfLines = 2
        summaryLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 6)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(lineTitleLabel)
        textStack.addArrangedSubview(lineSubtitleLabel)
        textStack.addArrangedSubview(summaryLabel)

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = PalmTheme.muted
        chevron.setContentHuggingPriority(.required, for: .horizontal)
        chevron.isUserInteractionEnabled = false

        let row = UIStackView(axis: .horizontal, spacing: 14, alignment: .center)
        row.isUserInteractionEnabled = false
        row.addArrangedSubview(previewImageView)
        row.addArrangedSubview(textStack)
        row.addArrangedSubview(chevron)
        addPinnedSubview(row, insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 14))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class PalmVariantView: UIView {
    init(variant: PalmVariant) {
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor

        let titleLabel = UILabel()
        titleLabel.text = variant.title
        titleLabel.font = PalmTheme.roundedFont(size: 19, weight: .bold)
        titleLabel.textColor = PalmTheme.ink

        let meaningLabel = UILabel()
        meaningLabel.text = variant.meaning
        meaningLabel.font = PalmTheme.roundedFont(size: 16, weight: .regular)
        meaningLabel.textColor = PalmTheme.muted
        meaningLabel.numberOfLines = 0

        let observationLabel = UILabel()
        observationLabel.text = variant.observation
        observationLabel.font = PalmTheme.roundedFont(size: 14, weight: .regular)
        observationLabel.textColor = UIColor(red: 0.48, green: 0.40, blue: 0.35, alpha: 1)
        observationLabel.numberOfLines = 0

        let stack = UIStackView(axis: .vertical, spacing: 8)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(meaningLabel)
        stack.addArrangedSubview(observationLabel)
        addPinnedSubview(stack, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class KNPalmRootTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = PalmTheme.green
        tabBar.unselectedItemTintColor = UIColor(red: 0.52, green: 0.57, blue: 0.55, alpha: 1)
        tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.96)
        tabBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white.withAlphaComponent(0.96)
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }

        viewControllers = [
            makeNav(KNPalmAtlasHomeViewController(), spec: PalmistryRepository.tabSpecs[0]),
            makeNav(KNPalmGalleryRootViewController(), spec: PalmistryRepository.tabSpecs[1]),
            makeNav(KNPalmLearnViewController(), spec: PalmistryRepository.tabSpecs[2]),
            makeNav(KNPalmMineViewController(), spec: PalmistryRepository.tabSpecs[3])
        ]
    }

    private func makeNav(_ root: UIViewController, spec: PalmTabSpec) -> UIViewController {
        makeNav(root, title: PalmL10n.text(spec.titleKey), symbol: spec.symbolName)
    }

    private func makeNav(_ root: UIViewController, title: String, symbol: String) -> UIViewController {
        root.title = title
        let nav = UINavigationController(rootViewController: root)
        nav.navigationBar.prefersLargeTitles = false
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: symbol), selectedImage: UIImage(systemName: "\(symbol).fill"))
        return nav
    }
}

private func palmSectionHeading(title: String, subtitle: String? = nil) -> UIView {
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = PalmTheme.roundedFont(size: 24, weight: .bold)
    titleLabel.textColor = PalmTheme.ink
    titleLabel.numberOfLines = 0

    let stack = UIStackView(axis: .vertical, spacing: 6)
    stack.addArrangedSubview(titleLabel)

    if let subtitle {
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 15, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.numberOfLines = 0
        stack.addArrangedSubview(subtitleLabel)
    }

    return stack
}

private final class PalmActionCardButton: UIButton {
    let itemID: String

    init(itemID: String, title: String, subtitle: String, footnote: String? = nil, symbolName: String, accent: UIColor, accessibilityIdentifier: String) {
        self.itemID = itemID
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        self.accessibilityIdentifier = accessibilityIdentifier
        accessibilityLabel = title

        let iconView = UIImageView(image: UIImage(systemName: symbolName))
        iconView.tintColor = .white
        iconView.contentMode = .center
        iconView.backgroundColor = accent
        iconView.layer.cornerRadius = 22
        iconView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        iconView.isUserInteractionEnabled = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = PalmTheme.roundedFont(size: 21, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.numberOfLines = 0
        titleLabel.isUserInteractionEnabled = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 15, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.numberOfLines = 0
        subtitleLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 6)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        if let footnote {
            let footnoteLabel = UILabel()
            footnoteLabel.text = footnote
            footnoteLabel.font = PalmTheme.roundedFont(size: 13, weight: .semibold)
            footnoteLabel.textColor = accent
            footnoteLabel.numberOfLines = 0
            footnoteLabel.isUserInteractionEnabled = false
            textStack.addArrangedSubview(footnoteLabel)
        }

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = PalmTheme.muted
        chevron.setContentHuggingPriority(.required, for: .horizontal)
        chevron.isUserInteractionEnabled = false

        let row = UIStackView(axis: .horizontal, spacing: 14, alignment: .center)
        row.isUserInteractionEnabled = false
        row.addArrangedSubview(iconView)
        row.addArrangedSubview(textStack)
        row.addArrangedSubview(chevron)
        addPinnedSubview(row, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 14))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class PalmAtlasCategoryButton: UIButton {
    let category: PalmAtlasCategory

    init(category: PalmAtlasCategory) {
        self.category = category
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityIdentifier = "atlas.category.\(category.id)"
        accessibilityLabel = category.title

        let imageView = UIImageView(image: PalmImageStore.image(named: category.assetName))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 0.982, green: 0.984, blue: 0.946, alpha: 1)
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.heightAnchor.constraint(equalToConstant: 112).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = category.title
        titleLabel.font = PalmTheme.roundedFont(size: 18, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.78
        titleLabel.isUserInteractionEnabled = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = category.subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 12, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.numberOfLines = 2
        subtitleLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 3)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        let stack = UIStackView(axis: .vertical, spacing: 10)
        stack.isUserInteractionEnabled = false
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(textStack)
        addPinnedSubview(stack, insets: UIEdgeInsets(top: 10, left: 10, bottom: 12, right: 10))
        heightAnchor.constraint(equalToConstant: 188).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class PalmLineTileButton: UIButton {
    let line: PalmLine

    init(line: PalmLine) {
        self.line = line
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityIdentifier = "atlas.line.\(line.id)"
        accessibilityLabel = line.title

        let imageView = UIImageView(image: PalmImageStore.image(named: line.assetName))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = false
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 112).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = line.title
        titleLabel.font = PalmTheme.roundedFont(size: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.isUserInteractionEnabled = false

        let bodyLabel = UILabel()
        bodyLabel.text = line.summary
        bodyLabel.font = PalmTheme.roundedFont(size: 14, weight: .regular)
        bodyLabel.textColor = UIColor.white.withAlphaComponent(0.84)
        bodyLabel.numberOfLines = 3
        bodyLabel.isUserInteractionEnabled = false

        let statLabel = UILabel()
        statLabel.text = PalmL10n.format("line.image_count_format", line.atlasCount)
        statLabel.font = PalmTheme.roundedFont(size: 12, weight: .bold)
        statLabel.textColor = .white
        statLabel.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        statLabel.textAlignment = .center
        statLabel.layer.cornerRadius = 13
        statLabel.clipsToBounds = true
        statLabel.widthAnchor.constraint(equalToConstant: 58).isActive = true
        statLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        statLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 8)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(bodyLabel)
        textStack.addArrangedSubview(statLabel)

        let row = UIStackView(axis: .horizontal, spacing: 14, alignment: .center)
        row.isUserInteractionEnabled = false
        row.addArrangedSubview(imageView)
        row.addArrangedSubview(textStack)
        addPinnedSubview(row, insets: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14))

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 0.129, green: 0.310, blue: 0.263, alpha: 1).cgColor, PalmTheme.wine.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradient, at: 0)
        gradient.name = "lineTileGradient"
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 158).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first(where: { $0.name == "lineTileGradient" })?.frame = bounds
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class PalmGalleryThumbButton: UIButton {
    let item: PalmGalleryItem

    init(item: PalmGalleryItem) {
        self.item = item
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityIdentifier = "gallery.item.\(item.id)"
        accessibilityLabel = item.title

        let imageView = UIImageView(image: PalmImageStore.image(named: item.assetName))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.font = PalmTheme.roundedFont(size: 14, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.76
        titleLabel.isUserInteractionEnabled = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = item.subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 12, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.numberOfLines = 2
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.72
        subtitleLabel.isUserInteractionEnabled = false

        let stack = UIStackView(axis: .vertical, spacing: 7)
        stack.isUserInteractionEnabled = false
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        addPinnedSubview(stack, insets: UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8))
        heightAnchor.constraint(equalToConstant: 232).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class PalmGalleryFeaturedButton: UIButton {
    let item: PalmGalleryItem

    init(item: PalmGalleryItem) {
        self.item = item
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityIdentifier = "gallery.featured.\(item.id)"
        accessibilityLabel = item.title

        let imageView = UIImageView(image: PalmImageStore.image(named: item.assetName))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.widthAnchor.constraint(equalToConstant: 126).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 142).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.font = PalmTheme.roundedFont(size: 25, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.isUserInteractionEnabled = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = item.subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 14, weight: .semibold)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.86)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.isUserInteractionEnabled = false

        let zoomLabel = UILabel()
        zoomLabel.text = PalmL10n.text("gallery.detail.tap_to_zoom")
        zoomLabel.font = PalmTheme.roundedFont(size: 11, weight: .bold)
        zoomLabel.textColor = .white
        zoomLabel.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        zoomLabel.textAlignment = .center
        zoomLabel.layer.cornerRadius = 13
        zoomLabel.clipsToBounds = true
        zoomLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        zoomLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        zoomLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 8)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        textStack.addArrangedSubview(zoomLabel)

        let row = UIStackView(axis: .horizontal, spacing: 13, alignment: .center)
        row.isUserInteractionEnabled = false
        row.addArrangedSubview(imageView)
        row.addArrangedSubview(textStack)
        addPinnedSubview(row, insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))

        let gradient = CAGradientLayer()
        gradient.colors = [PalmTheme.green.cgColor, PalmTheme.wine.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.name = "featuredGradient"
        layer.insertSublayer(gradient, at: 0)
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 166).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first(where: { $0.name == "featuredGradient" })?.frame = bounds
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class PalmLessonDayButton: UIButton {
    let day: PalmLessonDay

    init(day: PalmLessonDay) {
        self.day = day
        super.init(frame: .zero)
        backgroundColor = PalmTheme.surface
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = PalmTheme.border.cgColor
        accessibilityIdentifier = "learn.day.\(day.index)"
        accessibilityLabel = day.title

        let imageView = UIImageView(image: PalmImageStore.image(named: day.items.first?.assetName ?? "p5100"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.widthAnchor.constraint(equalToConstant: 118).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 132).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = day.title
        titleLabel.font = PalmTheme.roundedFont(size: 22, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.numberOfLines = 2
        titleLabel.isUserInteractionEnabled = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = day.subtitle
        subtitleLabel.font = PalmTheme.roundedFont(size: 14, weight: .regular)
        subtitleLabel.textColor = PalmTheme.muted
        subtitleLabel.numberOfLines = 3
        subtitleLabel.isUserInteractionEnabled = false

        let countLabel = UILabel()
        countLabel.text = PalmL10n.format("learn.day.examples_format", day.items.count)
        countLabel.font = PalmTheme.roundedFont(size: 12, weight: .bold)
        countLabel.textColor = PalmTheme.green
        countLabel.isUserInteractionEnabled = false

        let textStack = UIStackView(axis: .vertical, spacing: 8)
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        textStack.addArrangedSubview(countLabel)

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = PalmTheme.muted
        chevron.setContentHuggingPriority(.required, for: .horizontal)
        chevron.isUserInteractionEnabled = false

        let row = UIStackView(axis: .horizontal, spacing: 14, alignment: .center)
        row.isUserInteractionEnabled = false
        row.addArrangedSubview(imageView)
        row.addArrangedSubview(textStack)
        row.addArrangedSubview(chevron)
        addPinnedSubview(row, insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 14))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func accessibilityActivate() -> Bool {
        sendActions(for: .touchUpInside)
        return true
    }
}

private final class KNPalmAtlasHomeViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.spacing = 16
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("atlas.home.title"), subtitle: PalmL10n.text("atlas.home.subtitle"), symbolName: "book"))

        let hero = PalmAtlasCategoryButton(category: PalmistryRepository.atlasCategories[0])
        hero.accessibilityIdentifier = "atlas.hero.lines"
        hero.addTarget(self, action: #selector(openCategory(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(hero)

        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("atlas.home.categories"), subtitle: PalmL10n.text("atlas.home.categories.subtitle")))
        stackView.addArrangedSubview(categoryGrid())
    }

    private func categoryGrid() -> UIView {
        let grid = UIStackView(axis: .vertical, spacing: 12)
        for start in stride(from: 0, to: PalmistryRepository.atlasCategories.count, by: 2) {
            let row = UIStackView(axis: .horizontal, spacing: 12)
            row.distribution = .fillEqually
            PalmistryRepository.atlasCategories[start..<min(start + 2, PalmistryRepository.atlasCategories.count)].forEach { category in
                let button = PalmAtlasCategoryButton(category: category)
                button.addTarget(self, action: #selector(openCategory(_:)), for: .touchUpInside)
                row.addArrangedSubview(button)
            }
            grid.addArrangedSubview(row)
        }
        return grid
    }

    @objc private func openCategory(_ sender: PalmAtlasCategoryButton) {
        if sender.category.id == "lines" {
            navigationController?.pushViewController(KNPalmLineOverviewViewController(), animated: true)
        } else {
            navigationController?.pushViewController(KNPalmStaticAtlasCategoryViewController(category: sender.category), animated: true)
        }
    }
}

private final class KNPalmLineOverviewViewController: PalmScrollViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = PalmL10n.text("line.overview.title")
        stackView.spacing = 16
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("line.overview.title"), subtitle: PalmL10n.text("line.overview.subtitle"), symbolName: "hand.draw"))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("line.overview.choose"), subtitle: PalmL10n.text("line.overview.choose.subtitle")))

        PalmistryRepository.lines.forEach { line in
            let button = PalmLineTileButton(line: line)
            button.addTarget(self, action: #selector(openLineGallery(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("line.overview.total"), subtitle: PalmL10n.text("line.overview.total.subtitle")))
        stackView.addArrangedSubview(PalmImagePanel(imageName: "liudaxianwen"))
    }

    @objc private func openLineGallery(_ sender: PalmLineTileButton) {
        navigationController?.pushViewController(KNPalmLineGalleryViewController(line: sender.line), animated: true)
    }
}

private final class KNPalmLineGalleryViewController: PalmScrollViewController {
    private let line: PalmLine
    private var items: [PalmGalleryItem] { PalmistryRepository.lineGalleryItems(for: line.id) }

    init(line: PalmLine) {
        self.line = line
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = PalmL10n.format("gallery.line.title_format", line.title)
        stackView.spacing = 14
        stackView.addArrangedSubview(PalmHeaderView(title: title ?? "", subtitle: PalmL10n.format("gallery.line.subtitle_format", line.atlasCount), symbolName: "square.grid.2x2"))
        if let featured = items.first(where: { $0.index == 8 }) ?? items.first {
            stackView.addArrangedSubview(featuredButton(featured))
        }
        stackView.addArrangedSubview(galleryGrid(items: items))
    }

    private func featuredButton(_ item: PalmGalleryItem) -> UIButton {
        let button = PalmGalleryFeaturedButton(item: item)
        button.addTarget(self, action: #selector(openFeatured), for: .touchUpInside)
        return button
    }

    private func galleryGrid(items: [PalmGalleryItem]) -> UIView {
        let grid = UIStackView(axis: .vertical, spacing: 10)
        for start in stride(from: 0, to: items.count, by: 2) {
            let row = UIStackView(axis: .horizontal, spacing: 10)
            row.distribution = .fillEqually
            items[start..<min(start + 2, items.count)].forEach { item in
                let button = PalmGalleryThumbButton(item: item)
                button.addTarget(self, action: #selector(openItem(_:)), for: .touchUpInside)
                row.addArrangedSubview(button)
            }
            if row.arrangedSubviews.count == 1 {
                let spacer = UIView()
                row.addArrangedSubview(spacer)
            }
            grid.addArrangedSubview(row)
        }
        return grid
    }

    @objc private func openFeatured() {
        guard let item = items.first(where: { $0.index == 8 }) ?? items.first else { return }
        navigationController?.pushViewController(KNPalmGalleryItemDetailViewController(item: item), animated: true)
    }

    @objc private func openItem(_ sender: PalmGalleryThumbButton) {
        navigationController?.pushViewController(KNPalmGalleryItemDetailViewController(item: sender.item), animated: true)
    }
}

private final class KNPalmGalleryItemDetailViewController: PalmScrollViewController {
    private let item: PalmGalleryItem

    init(item: PalmGalleryItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildContent()
    }

    private func buildContent() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        let lineTitle = PalmistryRepository.line(withID: item.lineID)?.title ?? ""
        title = PalmL10n.format("gallery.detail.title_format", lineTitle, item.index)
        stackView.spacing = 14
        stackView.addArrangedSubview(PalmHeaderView(title: title ?? item.title, subtitle: PalmL10n.text("gallery.detail.subtitle"), symbolName: "photo"))
        stackView.addArrangedSubview(detailImage())
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.position"), body: item.position, accent: PalmTheme.green))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.observation"), body: item.observation, accent: PalmTheme.rose))

        if KNCommerceRuntime.entitlementService.canReadDeepContent(for: item) {
            addDeepContentSections()
        } else {
            stackView.addArrangedSubview(lockedContentView())
        }
    }

    private func addDeepContentSections() {
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.traditional_reading"), body: item.traditionalReading, accent: PalmTheme.wine))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.modern_reading"), body: item.modernReading, accent: PalmTheme.green))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.misread"), body: item.misread, accent: PalmTheme.ochre))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.judgement"), body: item.judgement, accent: PalmTheme.wine))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.action_advice"), body: item.actionAdvice, accent: PalmTheme.green))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.disclaimer"), body: item.disclaimer, accent: PalmTheme.rose))
    }

    private func detailImage() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.94)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = PalmTheme.border.cgColor

        let imageView = UIImageView(image: PalmImageStore.image(named: item.assetName))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let badge = UILabel()
        badge.text = PalmL10n.text("gallery.detail.tap_to_zoom")
        badge.font = PalmTheme.roundedFont(size: 13, weight: .bold)
        badge.textColor = PalmTheme.green
        badge.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        badge.textAlignment = .center
        badge.layer.cornerRadius = 16
        badge.layer.borderWidth = 1
        badge.layer.borderColor = PalmTheme.border.cgColor
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(badge)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.28),
            badge.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            badge.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -14),
            badge.widthAnchor.constraint(equalToConstant: 86),
            badge.heightAnchor.constraint(equalToConstant: 32)
        ])
        return view
    }

    private func lockedContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = PalmTheme.surface
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = PalmTheme.border.cgColor

        let titleLabel = UILabel()
        titleLabel.text = PalmL10n.text("commerce.locked.title")
        titleLabel.font = PalmTheme.roundedFont(size: 22, weight: .bold)
        titleLabel.textColor = PalmTheme.ink
        titleLabel.numberOfLines = 0

        let bodyLabel = UILabel()
        bodyLabel.text = PalmL10n.text("commerce.locked.body")
        bodyLabel.font = PalmTheme.roundedFont(size: 16, weight: .regular)
        bodyLabel.textColor = PalmTheme.muted
        bodyLabel.numberOfLines = 0

        let stack = UIStackView(axis: .vertical, spacing: 12)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(bodyLabel)

        if KNCommerceRuntime.entitlementService.shouldRequestAds(region: KNCommerceRuntime.currentRegion) {
            let adButton = commerceButton(
                title: PalmL10n.text("commerce.unlock.watch_ad"),
                symbolName: "play.rectangle",
                backgroundColor: PalmTheme.green
            )
            adButton.addTarget(self, action: #selector(watchRewardedAd), for: .touchUpInside)
            stack.addArrangedSubview(adButton)
        }

        let paywallButton = commerceButton(
            title: PalmL10n.text("commerce.unlock.subscribe"),
            symbolName: "crown",
            backgroundColor: PalmTheme.wine
        )
        paywallButton.addTarget(self, action: #selector(openPaywall), for: .touchUpInside)
        stack.addArrangedSubview(paywallButton)

        view.addPinnedSubview(stack, insets: UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18))
        return view
    }

    private func commerceButton(title: String, symbolName: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: symbolName), for: .normal)
        button.tintColor = .white
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font = PalmTheme.roundedFont(size: 17, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return button
    }

    @objc private func watchRewardedAd() {
        KNCommerceRuntime.adProvider.showRewarded(from: self) { [weak self] rewarded in
            guard let self else { return }
            DispatchQueue.main.async {
                if rewarded {
                    KNCommerceRuntime.entitlementService.markRewardUnlocked(contentID: self.item.id)
                    self.buildContent()
                } else {
                    self.openPaywall()
                }
            }
        }
    }

    @objc private func openPaywall() {
        let controller = KNPalmPaywallViewController { [weak self] in
            self?.buildContent()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

private final class KNPalmPaywallViewController: PalmScrollViewController {
    private let onPurchaseCompleted: () -> Void

    init(onPurchaseCompleted: @escaping () -> Void) {
        self.onPurchaseCompleted = onPurchaseCompleted
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = PalmL10n.text("commerce.paywall.title")
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("commerce.paywall.title"), subtitle: PalmL10n.text("commerce.paywall.subtitle"), symbolName: "crown"))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("commerce.paywall.benefits.title"), body: PalmL10n.text("commerce.paywall.benefits.body"), accent: PalmTheme.green))

        let monthly = productButton(
            productID: KNCommerceRuntime.config.productIDs.monthly,
            title: PalmL10n.text("commerce.paywall.monthly"),
            subtitle: PalmL10n.text("commerce.paywall.monthly.subtitle"),
            symbolName: "calendar",
            accent: PalmTheme.green
        )
        let yearly = productButton(
            productID: KNCommerceRuntime.config.productIDs.yearly,
            title: PalmL10n.text("commerce.paywall.yearly"),
            subtitle: PalmL10n.text("commerce.paywall.yearly.subtitle"),
            symbolName: "calendar.badge.clock",
            accent: PalmTheme.ochre
        )
        let lifetime = productButton(
            productID: KNCommerceRuntime.config.productIDs.lifetime,
            title: PalmL10n.text("commerce.paywall.lifetime"),
            subtitle: PalmL10n.text("commerce.paywall.lifetime.subtitle"),
            symbolName: "infinity",
            accent: PalmTheme.wine
        )
        [monthly, yearly, lifetime].forEach { button in
            button.addTarget(self, action: #selector(productTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }

        let restore = commerceTextButton(title: PalmL10n.text("commerce.paywall.restore"))
        restore.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
        stackView.addArrangedSubview(restore)
    }

    private func productButton(productID: String, title: String, subtitle: String, symbolName: String, accent: UIColor) -> PalmActionCardButton {
        PalmActionCardButton(
            itemID: productID,
            title: title,
            subtitle: subtitle,
            symbolName: symbolName,
            accent: accent,
            accessibilityIdentifier: "commerce.product.\(productID)"
        )
    }

    private func commerceTextButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = PalmTheme.roundedFont(size: 16, weight: .bold)
        button.tintColor = PalmTheme.green
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }

    @objc private func productTapped(_ sender: PalmActionCardButton) {
        if #available(iOS 15.0, *) {
            Task { @MainActor in
                _ = try? await KNCommerceRuntime.storeKitService.loadProducts()
                let result = await KNCommerceRuntime.storeKitService.purchase(productID: sender.itemID)
                if result == .success {
                    onPurchaseCompleted()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @objc private func restoreTapped() {
        if #available(iOS 15.0, *) {
            Task { @MainActor in
                await KNCommerceRuntime.storeKitService.refreshEntitlements()
                if KNCommerceRuntime.entitlementService.isPremiumActive {
                    onPurchaseCompleted()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

private final class KNPalmGalleryRootViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.spacing = 14
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("gallery.root.title"), subtitle: PalmL10n.text("gallery.root.subtitle"), symbolName: "square.grid.2x2"))
        PalmistryRepository.lines.forEach { line in
            let button = PalmLineTileButton(line: line)
            button.addTarget(self, action: #selector(openLineGallery(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func openLineGallery(_ sender: PalmLineTileButton) {
        navigationController?.pushViewController(KNPalmLineGalleryViewController(line: sender.line), animated: true)
    }
}

private final class KNPalmFavoritesViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("favorites.title"), subtitle: PalmL10n.text("favorites.subtitle"), symbolName: "star"))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("favorites.empty.title"), body: PalmL10n.text("favorites.empty.body"), accent: PalmTheme.ochre))
    }
}

private final class KNPalmStaticAtlasCategoryViewController: PalmScrollViewController {
    private let category: PalmAtlasCategory

    init(category: PalmAtlasCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.title
        stackView.addArrangedSubview(PalmHeaderView(title: category.title, subtitle: category.subtitle, symbolName: "photo"))
        stackView.addArrangedSubview(PalmImagePanel(imageName: category.assetName))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("atlas.static.note.title"), body: PalmL10n.text("atlas.static.note.body"), accent: PalmTheme.green))
    }
}

private final class KNPalmTodayViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("today.title"), subtitle: PalmL10n.text("today.subtitle"), symbolName: "sun.max"))
        stackView.addArrangedSubview(todayQuestionCard())
        stackView.addArrangedSubview(PalmImagePanel(imageName: "palm_base_gpt"))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("today.section.continue"), subtitle: PalmL10n.text("today.section.continue.subtitle")))

        let primary = PalmActionCardButton(
            itemID: "seven-day",
            title: PalmL10n.text("today.primary.title"),
            subtitle: PalmL10n.text("today.primary.subtitle"),
            footnote: PalmL10n.text("today.primary.footnote"),
            symbolName: "calendar",
            accent: PalmTheme.green,
            accessibilityIdentifier: "today.primary"
        )
        primary.addTarget(self, action: #selector(openSevenDay), for: .touchUpInside)
        stackView.addArrangedSubview(primary)

        let library = PalmActionCardButton(
            itemID: "library",
            title: PalmL10n.text("today.library.title"),
            subtitle: PalmL10n.text("today.library.subtitle"),
            footnote: PalmL10n.text("today.library.footnote"),
            symbolName: "books.vertical",
            accent: PalmTheme.wine,
            accessibilityIdentifier: "today.library"
        )
        library.addTarget(self, action: #selector(openLibrary), for: .touchUpInside)
        stackView.addArrangedSubview(library)
    }

    private func todayQuestionCard() -> UIView {
        PalmInfoSectionView(
            title: PalmL10n.text("today.card.title"),
            body: PalmL10n.text("today.card.body"),
            accent: PalmTheme.ochre
        )
    }

    @objc private func openSevenDay() {
        navigationController?.pushViewController(KNPalmSevenDayViewController(), animated: true)
    }

    @objc private func openLibrary() {
        navigationController?.pushViewController(KNPalmLibraryViewController(), animated: true)
    }
}

private final class KNPalmCompassViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("compass.title"), subtitle: PalmL10n.text("compass.subtitle"), symbolName: "safari"))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("compass.map.title"), subtitle: PalmL10n.text("compass.map.subtitle")))
        stackView.addArrangedSubview(PalmImagePanel(imageName: "palm_base_gpt"))

        PalmistryRepository.compassSections.forEach { section in
            let button = PalmActionCardButton(
                itemID: section.id,
                title: section.title,
                subtitle: section.subtitle,
                footnote: section.detail,
                symbolName: section.symbolName,
                accent: section.accent,
                accessibilityIdentifier: "compass.section.\(section.id)"
            )
            button.addTarget(self, action: #selector(sectionTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func sectionTapped(_ sender: PalmActionCardButton) {
        guard let section = PalmistryRepository.compassSections.first(where: { $0.id == sender.itemID }) else { return }
        navigationController?.pushViewController(KNPalmCompassDetailViewController(section: section), animated: true)
    }
}

private final class KNPalmCompassDetailViewController: PalmScrollViewController {
    private let section: PalmCompassSection

    init(section: PalmCompassSection) {
        self.section = section
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = section.title
        stackView.addArrangedSubview(PalmHeaderView(title: section.title, subtitle: section.subtitle, symbolName: section.symbolName))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("compass.detail.reading_order"), body: section.detail, accent: section.accent))

        switch section.id {
        case "lines":
            addLineAtlas()
        case "mounts":
            addTopicItems(prefix: "compass.mounts.item", count: 4, accent: section.accent)
        case "signs":
            addTopicItems(prefix: "compass.signs.item", count: 4, accent: section.accent)
        default:
            addTopicItems(prefix: "compass.rhythm.item", count: 4, accent: section.accent)
        }
    }

    private func addLineAtlas() {
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("compass.lines.total_label"), body: PalmL10n.text("compass.lines.total_body"), accent: PalmTheme.green))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("compass.lines.collection.title"), subtitle: PalmL10n.text("compass.lines.collection.subtitle")))

        PalmistryRepository.lines.forEach { line in
            let row = PalmLineRowView(line: line)
            row.addTarget(self, action: #selector(lineTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(row)
        }
    }

    private func addTopicItems(prefix: String, count: Int, accent: UIColor) {
        (1...count).forEach { index in
            stackView.addArrangedSubview(
                PalmInfoSectionView(
                    title: PalmL10n.text("\(prefix).\(index).title"),
                    body: PalmL10n.text("\(prefix).\(index).body"),
                    accent: accent
                )
            )
        }
    }

    @objc private func lineTapped(_ sender: PalmLineRowView) {
        navigationController?.pushViewController(KNPalmLineDetailViewController(line: sender.line), animated: true)
    }
}

private final class KNPalmAskViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("ask.title"), subtitle: PalmL10n.text("ask.subtitle"), symbolName: "questionmark.bubble"))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("ask.guide.title"), body: PalmL10n.text("ask.guide.body"), accent: PalmTheme.green))

        PalmistryRepository.questionPaths.forEach { path in
            let button = PalmActionCardButton(
                itemID: path.id,
                title: path.title,
                subtitle: path.subtitle,
                footnote: path.focus,
                symbolName: path.symbolName,
                accent: path.accent,
                accessibilityIdentifier: "ask.path.\(path.id)"
            )
            button.addTarget(self, action: #selector(pathTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func pathTapped(_ sender: PalmActionCardButton) {
        guard let path = PalmistryRepository.questionPaths.first(where: { $0.id == sender.itemID }) else { return }
        navigationController?.pushViewController(KNPalmQuestionPathViewController(path: path), animated: true)
    }
}

private final class KNPalmQuestionPathViewController: PalmScrollViewController {
    private let path: PalmQuestionPath

    init(path: PalmQuestionPath) {
        self.path = path
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = path.title
        stackView.addArrangedSubview(PalmHeaderView(title: path.title, subtitle: path.subtitle, symbolName: path.symbolName))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("ask.detail.focus_title"), body: path.focus, accent: path.accent))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("ask.detail.steps_title"), subtitle: PalmL10n.text("ask.detail.steps_subtitle")))

        (1...4).forEach { index in
            stackView.addArrangedSubview(
                PalmInfoSectionView(
                    title: PalmL10n.text("ask.\(path.id).step.\(index).title"),
                    body: PalmL10n.text("ask.\(path.id).step.\(index).body"),
                    accent: path.accent
                )
            )
        }
    }
}

private final class KNPalmLearnViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("learn.title"), subtitle: PalmL10n.text("learn.subtitle"), symbolName: "map"))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("learn.guide.title"), body: PalmL10n.text("learn.guide.body"), accent: PalmTheme.ochre))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("learn.seven_day.title"), subtitle: PalmL10n.text("learn.seven_day.subtitle")))

        PalmistryRepository.lessonDays.forEach { day in
            let button = PalmLessonDayButton(day: day)
            button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func dayTapped(_ sender: PalmLessonDayButton) {
        navigationController?.pushViewController(KNPalmLessonDayDetailViewController(day: sender.day), animated: true)
    }
}

private final class KNPalmLessonDayDetailViewController: PalmScrollViewController {
    private let day: PalmLessonDay

    init(day: PalmLessonDay) {
        self.day = day
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = day.title
        stackView.addArrangedSubview(PalmHeaderView(title: day.title, subtitle: day.subtitle, symbolName: "map"))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("learn.day.detail.goal"), body: day.goal, accent: PalmTheme.green))
        stackView.addArrangedSubview(palmSectionHeading(title: PalmL10n.text("learn.day.detail.examples"), subtitle: PalmL10n.text("learn.day.detail.examples.subtitle")))
        stackView.addArrangedSubview(exampleGrid())
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("learn.day.detail.practice"), body: day.practice, accent: PalmTheme.wine))
    }

    private func exampleGrid() -> UIView {
        let grid = UIStackView(axis: .vertical, spacing: 12)
        for start in stride(from: 0, to: day.items.count, by: 2) {
            let row = UIStackView(axis: .horizontal, spacing: 12)
            row.distribution = .fillEqually
            day.items[start..<min(start + 2, day.items.count)].forEach { item in
                let button = PalmGalleryThumbButton(item: item)
                button.addTarget(self, action: #selector(itemTapped(_:)), for: .touchUpInside)
                row.addArrangedSubview(button)
            }
            if day.items.count - start == 1 {
                row.addArrangedSubview(UIView())
            }
            grid.addArrangedSubview(row)
        }
        return grid
    }

    @objc private func itemTapped(_ sender: PalmGalleryThumbButton) {
        navigationController?.pushViewController(KNPalmGalleryItemDetailViewController(item: sender.item), animated: true)
    }
}

private final class KNPalmSevenDayViewController: PalmScrollViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = PalmL10n.text("learn.seven_day.title")
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("learn.seven_day.title"), subtitle: PalmL10n.text("learn.seven_day.subtitle"), symbolName: "calendar"))
        (1...7).forEach { index in
            stackView.addArrangedSubview(
                PalmInfoSectionView(
                    title: PalmL10n.text("learn.day.\(index).title"),
                    body: PalmL10n.text("learn.day.\(index).body"),
                    accent: index < 4 ? PalmTheme.green : PalmTheme.wine
                )
            )
        }
    }
}

private final class KNPalmLibraryViewController: PalmScrollViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = PalmL10n.text("library.title")
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("library.title"), subtitle: PalmL10n.text("library.subtitle"), symbolName: "books.vertical"))
        PalmistryRepository.libraryCategories.forEach { category in
            stackView.addArrangedSubview(categoryView(category))
        }
    }

    private func categoryView(_ category: PalmLibraryCategory) -> UIView {
        let countText = PalmL10n.format("library.category.count_format", category.itemCount)
        return PalmInfoSectionView(title: category.title, body: "\(category.subtitle)\n\(countText)", accent: PalmTheme.green)
    }
}

private final class KNPalmMineViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("mine.title"), subtitle: PalmL10n.text("mine.subtitle"), symbolName: "person"))
        let favoritesButton = PalmActionCardButton(
            itemID: "favorites",
            title: PalmL10n.text("favorites.title"),
            subtitle: PalmL10n.text("favorites.subtitle"),
            symbolName: "star",
            accent: PalmTheme.ochre,
            accessibilityIdentifier: "mine.favorites"
        )
        favoritesButton.addTarget(self, action: #selector(openFavorites), for: .touchUpInside)
        stackView.addArrangedSubview(favoritesButton)
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("mine.note.title"), body: PalmL10n.text("mine.note.body"), accent: PalmTheme.green))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("mine.disclaimer.title"), body: PalmL10n.text("mine.disclaimer.body"), accent: PalmTheme.rose))
    }

    @objc private func openFavorites() {
        navigationController?.pushViewController(KNPalmFavoritesViewController(), animated: true)
    }
}

private final class KNPalmHomeViewController: PalmScrollViewController {
    private let imagePanel = PalmImagePanel(imageName: PalmistryRepository.lines[0].assetName)
    private let summaryView = PalmLineSummaryView()
    private var chips = [PalmLineChip]()
    private var selectedLine = PalmistryRepository.lines[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        build()
        selectLine(selectedLine)
    }

    private func build() {
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("home.title"), subtitle: PalmL10n.text("home.subtitle"), symbolName: "book"))

        let sectionTitle = sectionHeader(titleKey: "home.main_map.title", actionKey: "action.view_topics")
        stackView.addArrangedSubview(sectionTitle)
        stackView.addArrangedSubview(imagePanel)

        let chipGrid = UIStackView(axis: .vertical, spacing: 12)
        for rowLines in stride(from: 0, to: PalmistryRepository.lines.count, by: 3) {
            let row = UIStackView(axis: .horizontal, spacing: 12)
            row.distribution = .fillEqually
            PalmistryRepository.lines[rowLines..<min(rowLines + 3, PalmistryRepository.lines.count)].forEach { line in
                let chip = PalmLineChip(line: line)
                chip.addTarget(self, action: #selector(chipTapped(_:)), for: .touchUpInside)
                chips.append(chip)
                row.addArrangedSubview(chip)
            }
            chipGrid.addArrangedSubview(row)
        }
        stackView.addArrangedSubview(chipGrid)

        summaryView.onOpen = { [weak self] in
            guard let self else { return }
            self.openDetail(line: self.selectedLine)
        }
        stackView.addArrangedSubview(summaryView)

        stackView.addArrangedSubview(sectionHeader(titleKey: "home.beginner_path.title", actionKey: "action.all_lessons"))
        PalmistryRepository.pathSteps.prefix(2).forEach { step in
            stackView.addArrangedSubview(pathPreview(step: step))
        }
    }

    @objc private func chipTapped(_ sender: PalmLineChip) {
        guard let line = PalmistryRepository.line(withID: sender.lineID) else { return }
        selectLine(line)
    }

    private func selectLine(_ line: PalmLine) {
        selectedLine = line
        imagePanel.update(imageName: line.assetName)
        summaryView.configure(line: line)
        chips.forEach { $0.updateSelection($0.lineID == line.id) }
    }

    private func openDetail(line: PalmLine) {
        navigationController?.pushViewController(KNPalmLineDetailViewController(line: line), animated: true)
    }

    private func sectionHeader(titleKey: String, actionKey: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = PalmL10n.text(titleKey)
        titleLabel.font = PalmTheme.roundedFont(size: 25, weight: .bold)
        titleLabel.textColor = PalmTheme.ink

        let button = UIButton(type: .system)
        button.setTitle(PalmL10n.text(actionKey), for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = PalmTheme.muted
        button.titleLabel?.font = PalmTheme.roundedFont(size: 16, weight: .semibold)
        if actionKey == "action.view_topics" {
            button.addTarget(self, action: #selector(openAtlas), for: .touchUpInside)
        } else if actionKey == "action.all_lessons" {
            button.addTarget(self, action: #selector(openPath), for: .touchUpInside)
        }

        let row = UIStackView(axis: .horizontal, spacing: 12, alignment: .center)
        row.addArrangedSubview(titleLabel)
        row.addArrangedSubview(button)
        return row
    }

    @objc private func openAtlas() {
        tabBarController?.selectedIndex = 1
    }

    @objc private func openPath() {
        tabBarController?.selectedIndex = 2
    }

    private func pathPreview(step: PalmPathStep) -> UIView {
        let view = PalmInfoSectionView(title: "\(step.index). \(step.title)", body: step.action, accent: PalmTheme.green)
        return view
    }
}

private final class KNPalmAtlasViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("atlas.title"), subtitle: PalmL10n.text("atlas.subtitle"), symbolName: "book"))
        PalmistryRepository.lines.forEach { line in
            let row = PalmLineRowView(line: line)
            row.addTarget(self, action: #selector(lineTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(row)
        }
    }

    @objc private func lineTapped(_ sender: PalmLineRowView) {
        navigationController?.pushViewController(KNPalmLineDetailViewController(line: sender.line), animated: true)
    }
}

private final class KNPalmPathViewController: PalmScrollViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("path.title"), subtitle: PalmL10n.text("path.subtitle"), symbolName: "square.stack.3d.up"))
        PalmistryRepository.pathSteps.forEach { step in
            stackView.addArrangedSubview(stepView(step))
        }
    }

    private func stepView(_ step: PalmPathStep) -> UIView {
        let view = UIView()
        view.backgroundColor = PalmTheme.surface
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = PalmTheme.border.cgColor

        let badge = UILabel()
        badge.text = "\(step.index)"
        badge.textAlignment = .center
        badge.textColor = .white
        badge.font = PalmTheme.roundedFont(size: 18, weight: .bold)
        badge.backgroundColor = PalmTheme.green
        badge.layer.cornerRadius = 22
        badge.clipsToBounds = true
        badge.widthAnchor.constraint(equalToConstant: 44).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 44).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = step.title
        titleLabel.font = PalmTheme.roundedFont(size: 22, weight: .bold)
        titleLabel.textColor = PalmTheme.ink

        let actionLabel = UILabel()
        actionLabel.text = step.action
        actionLabel.font = PalmTheme.roundedFont(size: 16, weight: .semibold)
        actionLabel.textColor = PalmTheme.green
        actionLabel.numberOfLines = 0

        let detailLabel = UILabel()
        detailLabel.text = step.detail
        detailLabel.font = PalmTheme.roundedFont(size: 15, weight: .regular)
        detailLabel.textColor = PalmTheme.muted
        detailLabel.numberOfLines = 0

        let textStack = UIStackView(axis: .vertical, spacing: 8)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(actionLabel)
        textStack.addArrangedSubview(detailLabel)

        let row = UIStackView(axis: .horizontal, spacing: 14, alignment: .top)
        row.addArrangedSubview(badge)
        row.addArrangedSubview(textStack)
        view.addPinnedSubview(row, insets: UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18))
        return view
    }
}

private final class KNPalmPlanViewController: PalmScrollViewController {
    private var selectedIndexes = Set<Int>()
    private let progressLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(PalmHeaderView(title: PalmL10n.text("plan.title"), subtitle: PalmL10n.text("plan.subtitle"), symbolName: "person"))

        progressLabel.font = PalmTheme.roundedFont(size: 18, weight: .bold)
        progressLabel.textColor = PalmTheme.green
        stackView.addArrangedSubview(progressLabel)

        PalmistryRepository.planItemKeys.enumerated().forEach { index, key in
            let button = UIButton(type: .system)
            button.tag = index
            button.contentHorizontalAlignment = .left
            button.tintColor = PalmTheme.green
            button.setTitle("  \(PalmL10n.text(key))", for: .normal)
            button.titleLabel?.font = PalmTheme.roundedFont(size: 18, weight: .semibold)
            button.setTitleColor(PalmTheme.ink, for: .normal)
            button.backgroundColor = PalmTheme.surface
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = PalmTheme.border.cgColor
            button.heightAnchor.constraint(equalToConstant: 58).isActive = true
            button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        updateChecklist()
    }

    @objc private func toggle(_ sender: UIButton) {
        if selectedIndexes.contains(sender.tag) {
            selectedIndexes.remove(sender.tag)
        } else {
            selectedIndexes.insert(sender.tag)
        }
        updateChecklist()
    }

    private func updateChecklist() {
        progressLabel.text = PalmL10n.format("plan.progress_format", selectedIndexes.count, PalmistryRepository.planItemKeys.count)
        stackView.arrangedSubviews.compactMap { $0 as? UIButton }.forEach { button in
            let checked = selectedIndexes.contains(button.tag)
            button.setImage(UIImage(systemName: checked ? "checkmark.circle.fill" : "circle"), for: .normal)
            button.backgroundColor = checked ? UIColor(red: 0.895, green: 0.957, blue: 0.925, alpha: 1) : PalmTheme.surface
        }
    }
}

private final class KNPalmLineDetailViewController: PalmScrollViewController {
    private let line: PalmLine

    init(line: PalmLine) {
        self.line = line
        super.init(nibName: nil, bundle: nil)
        prefersNavigationBarHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = line.title
        stackView.addArrangedSubview(PalmHeaderView(title: line.title, subtitle: line.subtitle, symbolName: "hand.raised"))
        stackView.addArrangedSubview(PalmImagePanel(imageName: line.assetName))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.format("detail.observation_title_format", line.title), body: line.observation, accent: PalmTheme.green))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.traditional_meaning"), body: line.traditionalMeaning, accent: PalmTheme.wine))
        stackView.addArrangedSubview(PalmInfoSectionView(title: PalmL10n.text("detail.confusion"), body: line.confusionNote, accent: PalmTheme.ochre))

        let variantsTitle = UILabel()
        variantsTitle.text = PalmL10n.text("detail.variants")
        variantsTitle.font = PalmTheme.roundedFont(size: 25, weight: .bold)
        variantsTitle.textColor = PalmTheme.ink
        stackView.addArrangedSubview(variantsTitle)
        line.variants.forEach { variant in
            stackView.addArrangedSubview(PalmVariantView(variant: variant))
        }
    }
}
