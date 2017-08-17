//
//  RadioSectionSpec.swift
//  QuickTableViewController
//
//  Created by Ben on 17/08/2017.
//  Copyright © 2017 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Nimble
import Quick
import QuickTableViewController

internal final class RadioSectionSpec: QuickSpec {

  override func spec() {
    describe("initialization") {
      let row = OptionRow(title: "", isSelected: false, action: nil)
      let section = RadioSection(title: "title", options: [row], footer: "footer")

      it("should initialize with given parameters") {
        expect(section.title) == "title"
        expect(section.rows).to(haveCount(1))
        expect(section.rows.first as? OptionRow) == row
        expect(section.options).to(haveCount(1))
        expect(section.options.first) == row
        expect(section.footer) == "footer"
      }
    }

    describe("toggle options") {
      let mock = {
        return RadioSection(title: "Radio", options: [
          OptionRow(title: "Option 1", isSelected: true, action: nil),
          OptionRow(title: "Option 2", isSelected: false, action: nil),
          OptionRow(title: "Option 3", isSelected: false, action: nil)
        ])
      }

      context("toggle option that's selected") {
        let section = mock()
        _ = section.toggle(section.options[0])

        it("should deselect the option") {
          expect(section.selectedOption).to(beNil())
          expect(section.options[0].isSelected) == false
          expect(section.options[1].isSelected) == false
          expect(section.options[2].isSelected) == false
        }
      }

      context("toggle option when there's nothing selected") {
        let section = mock()
        _ = section.toggle(section.options[0])
        _ = section.toggle(section.options[1])

        it("should deselect the option") {
          expect(section.selectedOption) == section.options[1]
          expect(section.options[0].isSelected) == false
          expect(section.options[1].isSelected) == true
          expect(section.options[2].isSelected) == false
        }
      }

      context("toggle option when there's already another option selected") {
        let section = mock()
        _ = section.toggle(section.options[2])

        it("should deselect the other option") {
          expect(section.selectedOption) == section.options[2]
          expect(section.options[0].isSelected) == false
          expect(section.options[1].isSelected) == false
          expect(section.options[2].isSelected) == true
        }
      }
    }
  }

}
