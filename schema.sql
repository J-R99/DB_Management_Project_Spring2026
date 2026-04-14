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
  -- UserID INT NOT NULL,
  -- PostID INT NOT NULL,
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
    `Status` VARCHAR(50), -- (rejected,accepted,blocked,pending)
    Request_Sent_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (FriendID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE `Follows` (
    FollowID INT AUTO_INCREMENT PRIMARY KEY,
    FollowerID INT NOT NULL,
    FollowedID INT NOT NULL,
    Follow_date DATE DEFAULT (CURRENT_DATE),
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

INSERT INTO Users (Username, password, email, privacy_setting, location, bio, date_joined) 
VALUES
('alice99', 'pass1', 'alice@email.com', 'public', 'New York, NY', 'Just here to vibe.', '2023-01-15'),
('bob_smith', 'pass2', 'bob@email.com', 'friends-only', 'Los Angeles, CA', 'Coffee and code.', '2023-03-22'),
('carol_j', 'pass3', 'carol@email.com', 'public', 'Chicago, IL', 'Photographer and traveler.', '2023-05-10'),
('dave_k', 'pass4', 'dave@email.com', 'private', 'Houston, TX', 'Sports fan.', '2023-07-04'),
('eve_online', 'pass5', 'eve@email.com', 'public', 'Phoenix, AZ', 'Dog mom. Avid reader.', '2023-09-30');

INSERT INTO Posts (UserID, Content_Type, Content_Data, Location_Tag, Visibility_Setting) 
VALUES
(1, 'text', 'Beautiful morning in New York today.', 'New York, NY', 'public'),
(2, 'text', 'New coffee shop opened up on Glendale, worth a visit!', 'Los Angeles, CA', 'public'),
(3, 'image', 'Check out this sunset I captured last night. IPhoneIMG47812.jpg', 'Chicago, IL', 'public'),
(4, 'text', 'Who"s coming over to watch the game tomorrow?', 'Houston, TX', 'friends-only'),
(5, 'video', 'My dog learned a new trick today! IPhoneVID132.mp4', 'Phoenix, AZ', 'public');

INSERT INTO Comments (PostID, UserID, Comment_text) 
VALUES
(1, 2, 'Looks amazing, wish I was there.'),
(1, 3, 'What a vibe, NYC is on my bucket list.'),
(2, 1, 'Looks great, I"ll have to give it a try when I visit LA!'),
(3, 4, 'Stunning view.'),
(5, 1, 'So cute!');



INSERT INTO Friendships (UserID,FriendID,`Status`,Request_Sent_date)
VALUES
(1,2,'Accepted','2026-04-01'),
(3,1,'Accepted','2026-04-04'),
(4,2,'Rejected','2026-04-06'),
(5,3,'Pending','2026-04-10'),
(3,2,'Blocked','2026-04-13');

INSERT INTO `Follows` (FollowerID,FollowedID,Follow_date)
VALUES
(1,2,'2026-04-02'),
(2,5,'2026-04-03'),
(3,5,'2026-04-07'),
(5,3,'2026-04-09'),
(4,2,'2026-04-13');

INSERT INTO Messages ( MessengerID,RecipientID, Content_Type, Content_Data,Read_status)
VALUES
(1, 2, 'text', 'Hey, how are you?', 1),
(2, 1, 'text', 'I am good!', 1),
(3, 4, 'image', 'photo_url_1.jpg', 0),
(4, 5, 'video', 'video_url_1.mp4', 0),
(5, 1, 'text', 'Let’s meet up', 1);

INSERT INTO Notifications (NotifiedID, Notification_type, Notification_status)
VALUES
(1, 'like', 'unread'),
(2, 'message', 'read'),
(3, 'follow', 'unread'),
(4, 'friend_request', 'unread'),
(5, 'comment', 'read');

INSERT INTO `Groups` (Group_name, Group_Description, Privacy_setting)
VALUES
('Gamers Hub', 'All about gaming', 'public'),
('Fitness Club', 'Workout and health', 'private'),
('Book Lovers', 'Reading community', 'public'),
('Music Fans', 'Discuss music', 'public'),
('Travel Squad', 'Travel experiences', 'private');

INSERT INTO Group_members(MemberID,GroupID,member_role,date_joined)
VALUES
(1,2,'Admin','2026-04-02'),
(2,1,'Member','2026-04-02'),
(3,5,'Admin','2026-04-03'),
(4,3,'Member','2026-04-03'),
(5,4,'Admin','2026-04-04');



Select U.UserID, C.PostID,C.CommentID,C.Comment_text

from Comments C join `Users` U
on C.`UserID`= U.`UserID`;