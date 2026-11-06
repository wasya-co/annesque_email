

  http://localhost:9002/email/api/messages/postal-webhook/[secret]

  http://localhost:9002/email/api/messages/from-postal/[secret]

= Install =

  After installing haraka

    npm install haraka -g
    npm install address-rfc2822 -g

  From: https://wasyaco.com/2026/articles/fixed-postal-server-error-internal-error-occurred-while-sending-message-mysql2error

  You may need to change mysql db:

    ALTER TABLE spam_checks MODIFY description VARCHAR(500);

