
;; STX Decentralized Social Media Platform Smart Contract


(define-fungible-token ciphersocial-token)

;; traits
;;
;; Define the contract owner (admin)
(define-constant contract-owner tx-sender)

;; token definitions
;;
;; Define the data structure for a user profile
(define-map user-profiles principal
    {
        username: (string-utf8 30),
        bio: (string-utf8 160),
        posts: (list 100 uint),
        followers: (list 1000 principal),
        following: (list 1000 principal),
        token-balance: uint,
        is-admin: bool
    })

;; constants
;;
;; Define the data structure for a post
(define-map posts uint 
    {
        author: principal,
        content: (string-utf8 280),
        timestamp: uint,
        likes: uint,
        comments: (list 100 uint),
        is-flagged: bool,
        flags-count: uint
    })

;; data vars
;;
;; Counter for post IDs
(define-data-var post-id-counter uint u0)

;; data maps
;;
;; Define the data structure for a comment
(define-map comments uint 
    {
        author: principal,
        post-id: uint,
        content: (string-utf8 280),
        timestamp: uint,
        is-flagged: bool,
        flags-count: uint
    })

;; public functions
;;
;; Counter for comment IDs
(define-data-var comment-id-counter uint u0)

;; read only functions
;;
;; Function to create a new user profile
(define-public (create-profile (username (string-utf8 30)) (bio (string-utf8 160)))
    (let ((caller tx-sender))
        (asserts! (is-none (map-get? user-profiles caller)) (err u1)) ;; Profile already exists
        (asserts! (>= (len username) u1) (err u11)) ;; Username must not be empty
        (asserts! (>= (len bio) u0) (err u17)) ;; Bio can be empty, but must not be invalid
        (ok (map-set user-profiles caller {
            username: username,
            bio: bio,
            posts: (list),
            followers: (list),
            following: (list),
            token-balance: u0,
            is-admin: false
        }))
    )
)

;; private functions
;;
;; Function to create a new post
(define-public (create-post (content (string-utf8 280)))
    (let (
        (caller tx-sender)
        (post-id (+ (var-get post-id-counter) u1))
    )
        (asserts! (>= (len content) u1) (err u12)) ;; Content must not be empty
        (var-set post-id-counter post-id)
        (ok (map-set posts post-id {
            author: caller,
            content: content,
            timestamp: stacks-block-height,
            likes: u0,
            comments: (list),
            is-flagged: false,
            flags-count: u0
        }))
    )
)

;; Function to like a post
(define-public (like-post (post-id uint))
    (match (map-get? posts post-id)
        post (ok (map-set posts post-id (merge post {likes: (+ (get likes post) u1)})))
        (err u13) ;; Post not found
    )
)
