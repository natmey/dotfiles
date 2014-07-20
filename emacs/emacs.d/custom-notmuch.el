
;; custom-notmuch.el -- my notmuch mail configuration


;; add here stuff required to be configured *before*
;; notmuch is loaded;

;; load notmuch
(require 'notmuch)
;;(require 'org-notmuch)


;; Add a binding for message decryption
(setq notmuch-crypto-process-mime 't)

;; add html handling
;;(load-library "mm-decode") (setq mm-text-html-renderer "w3m")

;; this will keep unused sent mail buffers from piling up
(setq message-kill-buffer-on-exit t)

;; ;;  Add a toggle keybinding for "w" as unread/inbox toggle
(define-key notmuch-search-mode-map "w"
  (lambda ()
    "toggle unread and inbox tag for message"
    (interactive)
    (notmuch-search-tag '("-inbox" "-unread"))
    (notmuch-search-next-thread)))



(define-key notmuch-search-mode-map "S"
  (lambda ()
    "mark messages in thread as spam"
    (interactive)
    (notmuch-search-tag '("+spam" "+deleted" "-inbox" "-unread"))
    (notmuch-search-next-thread)))

    (define-key notmuch-search-mode-map "d"
      (lambda ()
        "mark messages in thread as deleted"
        (interactive)
        (notmuch-search-tag '("+deleted" "-inbox" "-unread"))
        (notmuch-search-next-thread)))

    (define-key notmuch-search-mode-map "N"
      (lambda ()
        "mark messages in thread as read"
        (interactive)
        (notmuch-search-tag '("-unread"))
        (notmuch-search-next-thread)))

(define-key notmuch-show-mode-map "v" 'notmuch-show-view-part)

;; ;; gnus-alias
(autoload 'gnus-alias-determine-identity "gnus-alias" "" t)
(add-hook 'message-setup-hook 'gnus-alias-determine-identity)

    ;; Define two identities, "home" and "work"
    (setq gnus-alias-identity-alist
          '(("home"
             nil ;; Does not refer to any other identity
             "Nat Meysenburg <nat@stealthisemail.com>" ;; Sender address
             nil ;; No organization header
             nil ;; No extra headers
             nil ;; No extra body text
;; comment below and uncomment next for sig
             nil )
;;             "~/.signature")
            ("work"
             nil
             "Nat Meysenburg <nat@opentechinstitute.org>"
             "Open Technology Institute"
             nil
;;             (("Bcc" . "john.doe@example.com"))
             nil
;; comment below and uncomment next for sig
             nil )))
;             "~/.signature.work")))
    ;; Use "home" identity by default
    (setq gnus-alias-default-identity "home")
    ;; Define rules to match work identity
    (setq gnus-alias-identity-rules '(
      ("work" ("any" "nat@opentechinstitute.org" both) "work")
    ))
    ;; Determine identity when message-mode loads
    (add-hook 'message-setup-hook 'gnus-alias-determine-identity)
    ;; Sign messages by default.
    (add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)

(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "/usr/bin/exo-open"
      browse-url-browser-function gnus-button-url)
