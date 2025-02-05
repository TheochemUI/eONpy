;;; clean_and_convert.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Rohit Goswami (HaoZeke)
;;
;; Author: Rohit Goswami (HaoZeke) <rohit.goswami@aol.com>
;; Maintainer: Rohit Goswami (HaoZeke) <rohit.goswami@aol.com>
;; Created: June 21, 2024
;; Modified: June 21, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
;; Emacs script to clean and convert all Org mode files in docs/source to Markdown without generating TOC
;; Kanged out of openblas_buildsys_snip

(defun ensure-package-installed (&rest packages)
  "Ensure PACKAGES are installed. If not, install them."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-refresh-contents)
       (package-install package)))
   packages))

;; Initialize package system and ensure org is installed
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(ensure-package-installed 'org)

(defun my-org-md-export-to-markdown-no-toc ()
  "Export the current Org buffer to a Markdown file without a TOC."
  (let ((org-export-with-toc nil))
    (org-md-export-to-markdown)))

(defun convert-org-files-to-md ()
  "Convert all Org files in the 'docs/source' directory to Markdown without generating TOC."
  (let ((default-directory (expand-file-name "docs/source")))
    (dolist (file (directory-files-recursively default-directory "\\.org$"))
      (with-current-buffer (find-file-noselect file)
        (let ((output-file (concat (file-name-sans-extension file) ".md")))
          (my-org-md-export-to-markdown-no-toc)
          (rename-file (concat (file-name-sans-extension file) ".md") output-file t)
          (kill-buffer))))))

(defun clean-md-files ()
  "Remove Markdown files that have corresponding Org files in the 'docs/source' directory."
  (let ((default-directory (expand-file-name "docs/source")))
    (dolist (file (directory-files-recursively default-directory "\\.org$"))
      (let ((md-file (concat (file-name-sans-extension file) ".md")))
        (when (file-exists-p md-file)
          (delete-file md-file)
          (message "Deleted file: %s" md-file))))))

(defun clean-and-convert-org-files-to-md ()
  "Clean Markdown files that have corresponding Org files and convert all Org files to Markdown without generating TOC."
  (interactive)
  (clean-md-files)
  (convert-org-files-to-md))

;; Run the clean and conversion function
(clean-and-convert-org-files-to-md)
