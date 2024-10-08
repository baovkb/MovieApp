import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/core/utils/theme.dart';
import 'package:movie_app/features/account/data/repositories/account_repository_impl.dart';
import 'package:movie_app/features/account/data/sources/local_data/account_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/entities/account.dart';
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

    accountRepoImpl = AccountRepositoryImpl(AccountApiClient(Client()), AccountDB());

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
    final themeMode = context.read<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocConsumer<GetAccountBloc, GetAccountState>(
          builder: (context, getAccountState) {
            if (getAccountState is GetAccountInitial || getAccountState is GetAccountLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white,),);
            }
            else if (getAccountState is GetAccountLoaded) {
              Account account = getAccountState.account;
              final String avatarPath = 'https://image.tmdb.org/t/p/w400${account.avatar['tmdb']['avatar_path']}';

              return Stack(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 24),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(avatarPath)),
                              border: Border.all(
                                  width: 2,
                                  color: CustomColor.mainLightColor
                              )
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          account.name.isEmpty ? '(No name)' : account.name,
                          style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Username: ', style: TextStyle(fontSize: 18)),
                              Text(account.username, style: TextStyle(fontSize: 18))
                            ]
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.dark_mode),
                             Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text('Dark mode', style: TextStyle(fontWeight: FontWeight.bold),))),
                            Switch(
                                activeColor: colorScheme.onSurface,
                                value: themeMode.mode == ThemeMode.dark,
                                onChanged: (enable) {
                                  themeMode.toggleMode();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(Icons.settings),
                  )
                ] 
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
