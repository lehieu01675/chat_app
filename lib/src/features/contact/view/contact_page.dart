import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/contact/bloc/contact_bloc.dart';
import 'package:chatapp/src/features/contact/widgets/search_bar.dart';
import 'package:chatapp/src/features/contact/widgets/show_id.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/widgets/custom_chat_card.dart';
import 'package:chatapp/src/features/contact/repositories/contact_repo.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _searchController = TextEditingController();
  List<UserModel> _listContactUser = [];
  bool _isSearch = false;
  List<UserModel> _searchListContactUser = [];
  final String _notiWhenNoChatuser =
      'Let us take care of your relationships 😘';

  late UserModel currentUser;

  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  @override
  void initState() {
    super.initState();
    currentUser = _currentUserCache.get('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ContactBloc(contactRepository: ContactRepository()),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadChatUserSuccess) {
            _listContactUser = state.listContactUser;
            return (_listContactUser.isEmpty)
                ? Center(
                    child: Text(_notiWhenNoChatuser,
                        textAlign: TextAlign.center, maxLines: 2))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      SearchBarWidget(
                        searchController: _searchController,
                        onSearch: _search,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: _isSearch
                              ? _searchListContactUser.length
                              : _listContactUser.length,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index) {
                            return CustomChatCard(
                                onPressed: (context) {
                                  _removeUser(
                                      context: context,
                                      id: _listContactUser[index].id);
                                },
                                isChatPage: false,
                                currentUser: currentUser,
                                guestUser: _isSearch
                                    ? _searchListContactUser[index]
                                    : _listContactUser[index],
                                subTitle: ShowIDWidget(
                                  isSearch: _isSearch,
                                  searchListContactUser: _searchListContactUser,
                                  listContactUser: _listContactUser,
                                  index: index,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    _addChatUser(
                                        context: context,
                                        checkId:
                                            _listContactUser[index].checkId);
                                    context.go(RoutePaths.chatPage);
                                  },
                                  icon:
                                      const Icon(Icons.chat_outlined, size: 30),
                                ));
                          }),
                    ]),
                  );
          }
          return const SizedBox();
        },
      ),
    ));
  }

  Future<void> _addChatUser(
      {required BuildContext context, required String checkId}) async {
    context
        .read<ContactBloc>()
        .add(ContactAddContactUserEvent(checkId: checkId));
  }

  void _search(String value) {
    _isSearch = (value.isEmpty) ? false : true;
    _searchListContactUser.clear();

    for (var user in _listContactUser) {
      if (user.name.toLowerCase().contains(value.toLowerCase()) ||
          user.checkId.toLowerCase().contains(value.toLowerCase())) {
        _searchListContactUser.add(user);
        setState(() {
          _searchListContactUser;
          _isSearch;
        });
      } else {
        setState(() {
          _searchListContactUser = [];
          _isSearch;
        });
      }
    }
  }

  void _removeUser({required BuildContext context, required String id}) async {
    context.read<ContactBloc>().add(ContactDeleteContactUserEvent(id: id));
  }
}
