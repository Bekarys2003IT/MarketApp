//
//  TestingPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import Foundation
import UIKit

class TestingPresenter {
    private var questions: [TestingModel]
       private var currentQuestionIndex = 0
       unowned var viewController: TestingViewController

       init(questions: [TestingModel], viewController: TestingViewController) {
           self.questions = questions
           self.viewController = viewController
       }
    func start() {
        displayCurrentQuestion()
    }
    private func displayCurrentQuestion(){
        let question = questions[currentQuestionIndex]
        let progress = Float(currentQuestionIndex + 1) / Float(questions.count + 1)
        viewController.configureQuestion(question, progress: progress)
    }
    func optionSelected(index: Int) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              if self.currentQuestionIndex < self.questions.count - 1 {
                  self.currentQuestionIndex += 1
                  self.displayCurrentQuestion()
              } else {
                  self.viewController.completeTest()
              }
          }
      }
}
