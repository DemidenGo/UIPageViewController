//
//  OnboardingViewController.swift
//  UIPageViewController
//
//  Created by Юрий Демиденко on 30.04.2023.
//

import UIKit

final class OnboardingViewController: UIPageViewController {

    private lazy var pages: [UIViewController] = {
        let red = UIViewController()
        red.view.backgroundColor = .systemRed

        let green = UIViewController()
        green.view.backgroundColor = .systemGreen

        let blue = UIViewController()
        blue.view.backgroundColor = .systemBlue

        return [red, green, blue]
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemBrown
        pageControl.pageIndicatorTintColor = .systemOrange
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupConstraints()
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }

    private func setupConstraints() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        if previousIndex >= 0 {
            return pages[previousIndex]
        } else {
            return pages.last
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        if nextIndex < pages.count {
            return pages[nextIndex]
        } else {
            return pages.first
        }
    }

    //    собственный иникатор текущей страницы UIPageViewController'a
    //
    //    func presentationCount(for pageViewController: UIPageViewController) -> Int {
    //        pages.count
    //    }
    //
    //    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    //        0
    //    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
