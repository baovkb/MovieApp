import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:movie_app/features/account/data/repositories/account_repository_impl.dart';
import 'package:movie_app/features/account/data/sources/local_data/session_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/usecases/create_session_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/request_token_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/create_session_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/account/get_account_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_event.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_state.dart';
import 'package:movie_app/features/account/presentation/bloc/account/request_token_bloc.dart';
import 'package:movie_app/features/account/presentation/page/approve_token/approve_token_screen.dart';
import 'package:movie_app/route/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final RequestTokenBloc requestTokenBloc;
  StreamSubscription<RequestTokenState>? requestTokenSub;
  StreamSubscription<CreateSessionState>? createSsSub;
  CreateSessionBloc? createSessionBloc;
  late final accountRepoImpl;

  @override
  void initState() {
    debugPrint('initState Profile screen');
    super.initState();
    context.read<GetAccountBloc>().add(GetAccountEvent());

    accountRepoImpl = AccountRepositoryImpl(AccountApiClient(Client()), SessionDB());

    requestTokenBloc = RequestTokenBloc(
        RequestTokenUseCase(accountRepoImpl));
  }

  @override
  void dispose() {
    requestTokenSub?.cancel();
    createSsSub?.cancel();
    requestTokenBloc.close();
    createSessionBloc?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GetAccountBloc, GetAccountState>(
          builder: (context, getAccountState) {
            debugPrint(getAccountState.toString());

            if (getAccountState is GetAccountInitial || getAccountState is GetAccountLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white,),);
            }
            else if (getAccountState is GetAccountLoaded) {
              return const Center(
                child: Text('account loaded', style: TextStyle(color: Colors.white),),
              );
            }
            return SizedBox();
          },
          listener: (context, getAccountState) {
            if (getAccountState is GetAccountError) {
              if (requestTokenSub == null) {
                requestTokenSub = requestTokenBloc.stream.listen((requestTokenState) {
                  if (requestTokenState is RequestTokenLoaded) {
                    String token = (requestTokenState).token;

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveTokenScreen(token: token)))
                        .then((accept) {
                      if (accept) {
                        createSessionBloc ??= CreateSessionBloc(
                            CreateSessionUseCase(accountRepoImpl));
                        createSessionBloc!.add(CreateSessionEvent(token));
                        createSsSub ??= createSessionBloc!.stream.listen((createSessionState){
                          if (createSessionState is CreateSessionLoaded) {
                            context.read<GetAccountBloc>().add(GetAccountEvent());
                          } else if (createSessionState is CreateSessionError) {
                            debugPrint('create session error: ${createSessionState.message}');
                          }
                        });


                      }
                    }, onError: (error) {});

                  }
                });
                requestTokenBloc.add(RequestTokenEvent());
              }

            } else {
              debugPrint('request token sub_ed but account not found');
              // requestTokenBloc.add(RequestTokenEvent());
            }
          }),
    );
  }
}
