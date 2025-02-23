# STXDecentraLink Smart Contract

## Overview
STXDecentraLink is a decentralized social media platform built on the Stacks blockchain. It enables users to create profiles, post content, follow other users, like posts, and comment. The platform includes a moderation system where users can flag inappropriate posts and comments, and admins have the authority to remove flagged content.

## Features
- **User Management**: Users can create profiles, follow others, and update their bio.
- **Posts & Comments**: Users can create posts, comment on posts, and like them.
- **Social Interactions**: Users can follow others and gain followers.
- **Moderation System**: Posts and comments can be flagged and removed by admins.
- **Admin Controls**: The contract owner can assign and revoke admin privileges.
- **Token Integration**: The contract defines the `ciphersocial-token`, which can be used for incentives.

## Smart Contract Components

### Token Definition
- Defines `ciphersocial-token` as a fungible token.

### User Profiles
- `user-profiles` map stores user details:
  - `username` (30 characters max)
  - `bio` (160 characters max)
  - `posts` (list of post IDs)
  - `followers` and `following` (list of principals)
  - `token-balance` (uint)
  - `is-admin` (boolean)

### Posts
- `posts` map stores post data:
  - `author` (principal)
  - `content` (280 characters max)
  - `timestamp` (uint)
  - `likes` (uint count)
  - `comments` (list of comment IDs)
  - `is-flagged` (boolean)
  - `flags-count` (uint count)

### Comments
- `comments` map stores comment data:
  - `author` (principal)
  - `post-id` (linked post ID)
  - `content` (280 characters max)
  - `timestamp` (uint)
  - `is-flagged` (boolean)
  - `flags-count` (uint count)

### Public Functions
- **User Functions**:
  - `create-profile(username, bio)`: Creates a new user profile.
  - `follow-user(user-to-follow)`: Allows users to follow others.
  - `get-profile(user)`: Retrieves a user's profile.

- **Post Functions**:
  - `create-post(content)`: Creates a new post.
  - `get-post(post-id)`: Retrieves post details.
  - `like-post(post-id)`: Likes a post.

- **Comment Functions**:
  - `add-comment(post-id, content)`: Adds a comment to a post.
  - `get-comment(comment-id)`: Retrieves comment details.
  - `get-post-comments(post-id)`: Retrieves all comments for a post.

- **Moderation Functions**:
  - `flag-post(post-id)`: Flags a post.
  - `flag-comment(comment-id)`: Flags a comment.
  - `remove-flagged-post(post-id)`: Removes flagged posts (admin only).
  - `remove-flagged-comment(comment-id)`: Removes flagged comments (admin only).

- **Admin Functions**:
  - `add-admin(user)`: Grants admin rights.
  - `remove-admin(user)`: Revokes admin rights.
  - `is-admin(user)`: Checks if a user is an admin.

## Usage Guide
1. **Deploy the Smart Contract**
   - Deploy the contract to the Stacks blockchain.
   - Assign the contract owner (admin privileges).

2. **User Registration**
   - Call `create-profile` with a username and bio to set up a profile.

3. **Creating Content**
   - Use `create-post` to publish content.
   - Use `add-comment` to engage in discussions.

4. **Engaging with Posts**
   - Call `like-post` to like a post.
   - Follow other users with `follow-user`.

5. **Moderation**
   - Flag inappropriate content with `flag-post` or `flag-comment`.
   - Admins can remove flagged content using `remove-flagged-post` or `remove-flagged-comment`.

6. **Admin Management**
   - The contract owner can assign admins with `add-admin`.
   - Admins can be removed using `remove-admin`.

## Error Codes
- `u1`: Profile already exists.
- `u3`: User profile not found.
- `u4`: Follow target not found.
- `u5`: Follow limit reached.
- `u9`: Comment limit reached.
- `u10`: Post not found.
- `u13`: Post not found when liking.
- `u14`: Cannot follow yourself.
- `u15`: Comment content must not be empty.
- `u18`: Post not found when flagging.
- `u19`: Comment not found when flagging.
- `u21`: Only admins can remove posts.
- `u24`: Only admins can remove comments.
- `u26`: Only contract owner can add admins.
- `u28`: Only contract owner can remove admins.
- `u36`: User is not an admin.

## Conclusion
CipherSocial is a decentralized platform designed to provide a secure and censorship-resistant social networking experience. By leveraging blockchain technology, it ensures transparency, user control, and enhanced content moderation through community participation and admin oversight.

