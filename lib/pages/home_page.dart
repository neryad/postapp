import 'package:flutter/material.dart';
import 'package:postapp/models/post_models.dart';
import 'package:postapp/services/post_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final formKey = GlobalKey<FormState>();
final editFormKey = GlobalKey<FormState>();

List<Post> posts = [];
Post posttModel = new Post();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('PostApp'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.note_add,
                ),
                onPressed: () => _postAlert(context))
          ],
          elevation: 0.0,
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: _ListPosts(context),
        ));
  }

  void _postAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Nuevo Post"),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _postTitle(),
                      _postContent(),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Volver a la lista",
                    style: TextStyle(color: Colors.teal),
                  )),
              FlatButton(
                  onPressed: () {
                    _subimt();

                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    "Guardar",
                    style: TextStyle(color: Colors.teal),
                  )),
            ],
          );
        });
  }

  Widget _postTitle() {
    return TextFormField(
      maxLength: 33,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.center,
      onSaved: (value) => posttModel.title = value,
      validator: (value) {
        if (isEmpty(value)) {
          return null;
        } else {
          return "Llenar Campos";
        }
      },
      decoration: InputDecoration(
        labelText: "Titulo",
        //counterText: '',
        labelStyle: TextStyle(color: Colors.teal),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        //hintText: 'Nombre artículo',
        //hintStyle: TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget _postContent() {
    return TextFormField(
      //  initialValue: posttModel.name,
      maxLength: 33,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.center,
      onSaved: (value) => posttModel.body = value,
      validator: (value) {
        if (isEmpty(value)) {
          return null;
        } else {
          return "Llenar Campos";
        }
      },
      decoration: InputDecoration(
        labelText: "Contenido",
        //counterText: '',
        labelStyle: TextStyle(color: Colors.teal),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        //hintText: 'Nombre artículo',
        //hintStyle: TextStyle(color: Colors.teal),
      ),
    );
  }

  bool isEmpty(String s) {
    return (s == "") ? false : true;
  }

  // this.userId,
  //     this.id,
  //     this.title,
  //     this.body,

  void _subimt() {
    var it = posts.length;
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    var post = new Post(
      userId: 10,
      //id,
      title: posttModel.title,
      body: posttModel.body,
    );
    posts.insert(it, post);
    formKey.currentState.reset();
  }

  _ListPosts(BuildContext context) {
    return Container(
      key: UniqueKey(),
      height: MediaQuery.of(context).size.height * .85,
      child: FutureBuilder<List<Post>>(
          future: getMyPost(),
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            //TODO Cambinor nombre de varible

            final lista = snapshot.data;

            if (lista.length == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No existen Post",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                  ),
                ),
              );
            }
            lista.sort((a, b) => a.id.compareTo(b.id));
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, i) {
                return _card(lista[i]);
              },
            );
          }),
    );
  }

  Widget _card(Post lista) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 125.00,
        //width: 100.00,
        child: Card(
          elevation: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(lista.id.toString()),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(lista.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ),

                    Divider(
                      color:Colors.teal
                    ),
                     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(lista.body,
                         
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ),
                  ],
                ),
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              //   Text(lista.userId.toString()),
              // ]),
            ],
          ),
        ),
      ),
    );
  }
}
