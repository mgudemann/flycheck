;;; test-declaration.el --- Tests for syntax checker declaration -*- lexical-binding: t; -*-

;; Copyright (c) 2013 Sebastian Wiesner <lunaryorn@gmail.com>
;;
;; Author: Sebastian Wiesner <lunaryorn@gmail.com>
;; URL: https://github.com/lunaryorn/flycheck

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ert)
(require 'flycheck)
(require 'dash)

(ert-deftest flycheck-error-pattern-p ()
  (should (flycheck-error-pattern-p '("foo" warning)))
  (should-not (flycheck-error-pattern-p '("foo" bar)))
  (should-not (flycheck-error-pattern-p "foo"))
  (should-not (flycheck-error-pattern-p 'warning)))

(ert-deftest flycheck-command-argument-cell-p-config-file ()
  (should (flycheck-command-argument-cell-p '(config-file "foo" bar)))
  (should-not (flycheck-command-argument-cell-p '(config-file "foo" 'bar)))
  (should-not (flycheck-command-argument-cell-p '(config-file "foo"))))

(ert-deftest flycheck-command-argument-cell-p-option ()
  (should (flycheck-command-argument-cell-p '(option "foo" bar)))
  (should (flycheck-command-argument-cell-p '(option "foo" bar filter)))
  (should-not (flycheck-command-argument-cell-p '(option "foo" 'bar)))
  (should-not (flycheck-command-argument-cell-p '(option "foo" bar 'filter)))
  (should-not (flycheck-command-argument-cell-p '(option "foo"))))

(ert-deftest flycheck-command-argument-cell-p-eval ()
  (should (flycheck-command-argument-cell-p '(eval bar)))
  (should (flycheck-command-argument-cell-p '(eval (bar))))
  (should-not (flycheck-command-argument-cell-p '(eval)))
  (should-not (flycheck-command-argument-cell-p '(eval foo bar))))

(ert-deftest flycheck-command-argument-cell-p-no-cell ()
  (should-not (flycheck-command-argument-cell-p "foo"))
  (should-not (flycheck-command-argument-cell-p 'foo))
  (should-not (flycheck-command-argument-cell-p '(foo bar))))

(ert-deftest flycheck-command-argument-p ()
  (--each '(source source-inplace source-original)
    (should (flycheck-command-argument-p it)))
  (should (flycheck-command-argument-p "foo"))
  (should (flycheck-command-argument-p '(eval bar)))
  (should-not (flycheck-command-argument-p '(foo bar)))
  (should-not (flycheck-command-argument-p 1)))

;; Local Variables:
;; coding: utf-8
;; End:

;;; test-declaration.el ends here