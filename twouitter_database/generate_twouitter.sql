use twouitter;
DROP TABLE IF EXISTS users;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `mail` varchar(250) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tweets` (
  `tweet_id` int NOT NULL AUTO_INCREMENT,
  `tweet_text` varchar(5000) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`tweet_id`),
  FOREIGN KEY (`user_id`) REFERENCES users(`id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO users (username,mail,password) 
VALUES 
    ("Endeavxor","endeavxor@university.fr","5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"),
    ("Quentin_A","quentin@university.fr","13152171529471b928bc20722b4e9aa92a94b6aed222104d444f21c779142765"),
    ("Vincent_J","vincent@university.fr","f256ff181ea8aee50adf8db7d7e1f7a3225fc9477637a632374dd0b4eb840527");


INSERT INTO tweets (tweet_text,created_at,user_id) 
VALUES 
    ("Lorem ipsum dolor, sit amet consectetur adipisicing elit. Consectetur nobis quisquam, corporis dolorum distinctio commodi eius, molestiae voluptas velit ab, quaerat nulla beatae sapiente placeat eum odio autem enim numquam?
Voluptate quam quos ea explicabo suscipit consequuntur eligendi sapiente iure labore nihil nemo veritatis molestias voluptas laboriosam nisi iste ab, exercitationem ex deserunt inventore, aliquam atque maxime odio voluptates. Voluptatem.",now(),1),

    ("Lorem ipsum dolor sit amet consectetur adipisicing elit.",now(),2),
    ("Consectetur nobis quisquam, corporis dolorum distinctio commodi eius",now(),3),
    ("Lorem ipsum dolor sit amet consectetur adipisicing elit. Ea facere et vel possimus ducimus earum, fugit, repudiandae dignissimos eum soluta voluptates quo dicta mollitia rem dolor commodi at? Repellendus, cumque.",now(),1);

