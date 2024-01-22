import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/group/msg_model.dart';
import 'package:proyecto_final/chat/msg_widget/other_msg_widget.dart';
import 'package:proyecto_final/chat/msg_widget/own_msg_widget.dart';
import 'package:proyecto_final/chatbotweb/customClipper.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:universal_platform/universal_platform.dart';

class GroupPage extends StatefulWidget {
  final String name;
  final String userId;
  final UsuariosModel usuario;
  final UsuariosModel usuarioLogin;
  const GroupPage(
      {super.key,
      required this.name,
      required this.userId,
      required this.usuario,
      required this.usuarioLogin});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;
  List<MsgModel> listMsg = [];
  TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:3000";
    } else {
      url = "http://127.0.0.1:3000";
    }

    socket = IO.io(url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print("connected into frontend");
      socket!.on("sendMsgServer", (msg) {
        print(msg);
        if (msg["userId"] != widget.userId) {
          setState(() {
            listMsg.add(
              MsgModel(
                  type: msg["type"],
                  msg: msg["msg"],
                  sender: msg["senderName"]),
            );
          });
        }
      });
    });
  }

  void sendMsg(String msg, String senderName) {
    MsgModel ownMsg = MsgModel(type: "ownMsg", msg: msg, sender: senderName);
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "senderName": senderName,
      "userId": widget.userId,
    });
  }

  void deleteConversation() {
    // Emitir un evento al servidor para borrar la conversación
    socket!.emit('deleteConversation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        toolbarHeight: 110,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: AppBarCustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    Color(0xFF7A6B26),
                  ]),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      child: Image.network(
                        widget.usuario.foto,
                        width: 37,
                        height: 37,
                      )),
                  Expanded(
                    child: Text(
                      widget.usuario.nombreCompleto,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.isDesktop(context) ||
                                Responsive.isTablet(context)
                            ? 30
                            : 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: listMsg.length,
                itemBuilder: (context, index) {
                  if (listMsg[index].type == "ownMsg") {
                    return OnwMsgWidget(
                        sender: listMsg[index].sender, msg: listMsg[index].msg);
                  } else {
                    return OtherMsgWidget(
                        sender: listMsg[index].sender, msg: listMsg[index].msg);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryColor,
                    )),
                Expanded(
                    child: TextFormField(
                  controller: _msgController,
                  decoration: const InputDecoration(
                      hintText: "Mensaje...",
                      hintStyle: TextStyle(color: primaryColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                  style: const TextStyle(color: primaryColor),
                )),
                IconButton(
                  onPressed: () {
                    String msg = _msgController.text;
                    if (msg.isNotEmpty) {
                      sendMsg(msg, widget.name);
                      _msgController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      deleteConversation();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
