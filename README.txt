

  http://localhost:9002/email/api/messages/postal-webhook/[secret]

  http://localhost:9002/email/api/messages/from-postal/[secret]

= Develop =

== onnx runtimes ==
  * https://github.com/intel/onnxruntime
  * https://github.com/syntax-syndicate/onnxruntime
  * https://github.com/raymondxyang/onnxruntime
  * https://sourceforge.net/projects/onnx-runtime.mirror/files/?__cf_chl_rt_tk=XyULIeCwmDLY4jbIdf.7Ju9cV8RftXXAGjuUGHJoGwc-1795017583-1.0.1.1-FnrGFy_x.5y324hOiUy8Acg.CSwCr4LFvHBsjIXdWQ0

= Install =

  After installing haraka

    npm install haraka -g
    npm install address-rfc2822 -g

  From: https://wasyaco.com/2026/articles/fixed-postal-server-error-internal-error-occurred-while-sending-message-mysql2error

  You may need to change mysql db:

    ALTER TABLE spam_checks MODIFY description VARCHAR(500);
