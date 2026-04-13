DROP DATABASE IF EXISTS SOCIAL_MEDIA_PLATFORM;

CREATE DATABASE SOCIAL_MEDIA_PLATFORM;

USE SOCIAL_MEDIA_PLATFORM;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(127) NOT NULL UNIQUE,
    password varchar(255),
    email varchar(255),
    privacy_setting VARCHAR(30), -- (public,friends-only,private)
    location VARCHAR(100),
    bio VARCHAR(255),
    date_joined DATE
);

CREATE TABLE Posts (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Content_Type VARCHAR(50),
    Content_Data TEXT,
    Time_Stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Location_Tag VARCHAR(50),
    Visibility_Setting VARCHAR(50),-- (public,friends-only,private)
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- CREATE TABLE Likes(
  -- LikeID INT AUTO_INCREMENT PRIMARY KEY,
  -- UserID INT,
  -- PostID INT,
  -- Time_Stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
  -- FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE
-- );

CREATE TABLE Comments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    Comment_text VARCHAR(255),
    Time_Stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Friendships (
    FriendshipID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FriendID INT NOT NULL,
    Status VARCHAR(50),
    Request_Sent_date DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (FriendID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Follows (
    FollowID INT AUTO_INCREMENT PRIMARY KEY,
    FollowerID INT NOT NULL,
    FollowedID INT NOT NULL,
    Follow_date DATE,
    FOREIGN KEY (FollowerID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (FollowedID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Messages (
    MessageID INT AUTO_INCREMENT PRIMARY KEY,
    MessengerID INT NOT NULL,
    RecipientID INT NOT NULL,
    Content_Type VARCHAR(50),
    Content_Data TEXT,
    Time_Stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Read_status VARCHAR(20),
    FOREIGN KEY (MessengerID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RecipientID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    NotifiedID INT NOT NULL,
    Notification_type VARCHAR(100), -- (follow,post_created,friend_request,likes,comments)
    Notification_status VARCHAR(20),
    Time_Stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (NotifiedID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE `Groups` (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    Group_name VARCHAR(255) NOT NULL UNIQUE,
    Group_Description TEXT,
    Privacy_setting VARCHAR(50) -- ('public,private,invitation-only')
);

Create TABLE Group_members(
MembershipID int AUTO_INCREMENT PRIMARY KEY,
MemberID INT NOT NULL,
GroupID INT NOT NULL,
member_role varchar(50),
date_joined DATE DEFAULT (CURRENT_DATE),
FOREIGN KEY (GroupID) REFERENCES `Groups`(GroupID) ON DELETE CASCADE,
FOREIGN KEY (MemberID) REFERENCES Users(UserID) ON DELETE CASCADE);



