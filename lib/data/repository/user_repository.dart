import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zhiliao/data/model/token_entity.dart';
import 'package:zhiliao/util/http_util.dart';

class UserRepository {
  Future<TokenEntity> authenticate({
    @required String email,
    @required String password,
  }) async {
    String token = await httpUtil.post("/token",data: {"email":email,"password":password});
    TokenEntity tokenEntity = TokenEntity().fromJson(json.decode(token));
    return tokenEntity;
  }

  Future<TokenEntity> register({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    String token = await httpUtil.post("/user",data: {"userName":username,"email":email,"password":password});
    TokenEntity tokenEntity = TokenEntity().fromJson(json.decode(token));
    return tokenEntity;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    httpUtil.deleteToken();
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    httpUtil.addToken(token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
