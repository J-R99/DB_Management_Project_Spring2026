-- To reset the entire database, dont include in SQL running code unless so.
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Follows;
DROP TABLE IF EXISTS Friendships;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS Users;


--Users instead of User (User is PostgreSQL keyword)
Create Table Users (
UserID int PRIMARY KEY,
Username varchar(255) NOT NULL UNIQUE,
Privacy_settings varchar(255),
Location varchar(255),
Bio varchar(255)
);

--Posts instead of Post
Create Table Posts(
  PostID int PRIMARY KEY,
  -- User who made the post
  UserID int references Users(UserID),
  Content_Type varchar(50),
  Content_Data varchar(255),
  Time_Stamp timestamp,
  Location_Tag varchar(255),
  Visibility_Setting varchar(255)
);

--Comments instead of Comment
Create Table Comments(
  CommentID int Primary Key,
  --Post comment is made in
  PostID int references Posts(PostID),
  --User who made the comment
  UserID int references Users(UserID),
  Comment_text varchar(255),
  Time_Stamp timestamp
);

--etc...
Create Table Friendships
(
  FriendshipID int PRIMARY KEY,
  --The user who we're referencing first
  UserID int references Users(UserID),
  --Friend of user we're referencing
  FriendID int references Users(UserID),
  Status varchar(50),
  Request_Sent_date date
);
  
Create Table Follows(
  FollowID int Primary Key,
  --Follower ID
  FollowerID int references Users(UserID),
  --User who is followed
  FollowedID int references Users(UserID),
  Follow_date date
);

Create Table Messages(
  MessageID int Primary Key,
  --User sending the message
  MessengerID int references Users(UserID),
  --User receiving the message
  RecipientID int references Users(UserID),
  Content_Type varchar(50),
  Content_Data varchar(255),
  Time_Stamp timestamp,
  Read_status varchar(20)
);

Create Table Notifications(
  NotificationID int Primary Key,
  --User who received notification
  NotifiedID int references Users(UserID),
  Notification_type varchar(100),
  Notification_status varchar(20),
  Time_Stamp timestamp
);

Create Table Groups(
  GroupID int Primary Key,
  Group_name varchar(255),
  Group_Description varchar(255),
  Primary_setting varchar(100)
);