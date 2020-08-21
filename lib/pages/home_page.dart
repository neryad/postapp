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
                    "Volver a la post",
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
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.teal,));
            }
            final post = snapshot.data;

            if (post.length == 0) {
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
            post.sort((a, b) => a.id.compareTo(b.id));
            return ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, i) {
                return _card(post[i]);
              },
            );
          }),
    );
  }

  Widget _card(Post post) {
    return new Card(
      elevation: 5.0,
      
      child: new Column(
        children: <Widget>[

          new Image(
            image: AssetImage('assets/undraw_font_kwpk.png'),
            fit: BoxFit.cover,
          ),
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              post.body,
              softWrap: true,
            ),
          ),
          Divider(color: Colors.teal),
          new Padding(
             
              padding: new EdgeInsets.all(
                  7.0), 
              child: new Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new FlatButton.icon(
                    icon: const Icon(Icons.note,
                        size: 18.0, color: Colors.teal),
                    label:  Text(post.id.toString()),
                    onPressed: () {
                      print('Me encanta');
                    },
                  ),
                  new FlatButton.icon(
                    icon: const Icon(Icons.update,
                        size: 18.0, color: Colors.orange),
                    label: const Text('Editar'),
                    onPressed: () {
                      print('Comenta algo');
                    },
                  ),
                  new FlatButton.icon(
                    icon: const Icon(Icons.remove_circle,
                        size: 18.0, color: Colors.redAccent),
                    label: const Text('Borrar'),
                    onPressed: () {
                      print('Compartelo');
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }

}
