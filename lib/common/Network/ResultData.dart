class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;
  var msg;

  ResultData(this.data, this.isSuccess, this.code, {this.headers,this.msg});
}
