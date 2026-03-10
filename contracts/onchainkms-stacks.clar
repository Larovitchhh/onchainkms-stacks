(define-map activities
  { id: uint }
  {
    owner: principal,
    activityType: (string-ascii 20),
    distance: uint,
    duration: uint,
    elevation: uint,
    xp: uint
  }
)

(define-data-var last-id uint u0)

(define-public (mint-activity
    (activityType (string-ascii 20))
    (distance uint)
    (duration uint)
    (elevation uint)
    (xp uint)
)

  (let
    (
      (new-id (+ (var-get last-id) u1))
    )

    (begin

      (map-set activities
        { id: new-id }
        {
          owner: tx-sender,
          activityType: activityType,
          distance: distance,
          duration: duration,
          elevation: elevation,
          xp: xp
        }
      )

      (var-set last-id new-id)

      (ok new-id)

    )
  )
)

(define-read-only (get-activity (id uint))
  (map-get? activities { id: id })
)
