/+  wasm=wasm-lia
/*  llama-cpp-wrapper  %wasm  /llama-cpp-wrapper/wasm
::
=*  script-wasm  script:lia-sur:wasm
=*  cw           coin-wasm:wasm-sur:wasm
=*  cws          (list cw)
=*  script-form  script-raw-form:lia-sur:wasm
::
=*  acc-mold  *
=/  arr  (arrows:wasm acc-mold)
=/  imports=(map (pair cord cord) $-(cws (script-form cws acc-mold)))
  ~  
::
:-  %say  |=  [[now=@da eny=@uvJ our=@p *] *]  :-  %noun
::
::  requires %data desk to exist with /weights/hoon file that produces octs
::
=/  weights
  !<  octs
  .^(vase %ca /(scot %p our)/data/(scot %da now)/weights/hoon)
::
%^  (run-once:wasm cord acc-mold)  [llama-cpp-wrapper *acc-mold imports]  %$
=/  m  (script-wasm cord acc-mold)
^-  form:m
=,  arr
;<  weights-u=@  try:m  (call-1 'malloc' p.weights ~)
::
;<  *  try:m  (memwrite weights-u p.weights q.weights)
;<  *  try:m  (call 'llama_cpp_init_from_gguf_bytes' weights-u p.weights ~)
::
=/  prompt=cord  'Q: What is the capital of the United Kingdom?\0aA: '
::  (chars + null terminator)
::
=/  len-prompt  +((met 3 prompt))
;<  str-u=@   try:m  (call-1 'malloc' len-prompt ~)
;<  *         try:m  (memwrite str-u len-prompt prompt)
;<  res-u=@   try:m  (call-1 'infer_c_string' str-u 0 ~)
;<  res-w=@   try:m  (call-1 'strlen' res-u ~)
;<  o=octs    try:m  (memread res-u res-w)
(return:m `cord`q.o)