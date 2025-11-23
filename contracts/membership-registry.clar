;; Added admin principal and error constants
(define-data-var admin principal tx-sender)

(define-constant ERR-ALREADY-MEMBER (err u1))
(define-constant ERR-NOT-FOUND (err u2))
(define-constant ERR-UNAUTHORIZED (err u3))

;; Added assert-admin helper function
(define-private (assert-admin)
  (if (is-eq tx-sender (var-get admin))
    (ok true)
    ERR-UNAUTHORIZED
  )
)

(define-map members
  {member: principal}
  {active: bool}
)

(define-read-only (is-member (user principal))
  (match (map-get? members {member: user})
    entry (ok (get active entry))
    (ok false)
  )
)

;; Add a new member (admin only)
(define-public (add-member (user principal))
  (begin
    (try! (assert-admin))
    ;; wrap map-get? with is-some to check if member exists (convert optional to bool)
    (if (is-some (map-get? members {member: user}))
        ERR-ALREADY-MEMBER
        (begin
          (map-set members {member: user} {active: true})
          (ok true)
        )
    )
  )
)

;; Remove a member (admin only)
(define-public (remove-member (user principal))
  (begin
    (try! (assert-admin))
    ;; wrap map-get? with is-some to check if member exists (convert optional to bool)
    (if (is-some (map-get? members {member: user}))
        (begin
          (map-set members {member: user} {active: false})
          (ok true)
        )
        ERR-NOT-FOUND
    )
  )
)
