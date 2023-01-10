import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_track/models/recipe_model.dart';
import 'package:image_picker/image_picker.dart';

class RecipeService {

  final String uid;
  RecipeService({ required this.uid });

  final CollectionReference<Map<String, dynamic>> recipesCollection = FirebaseFirestore.instance.collection('recipes');

  Future<List<RecipeModel>> getUserRecipes() async {
    final QuerySnapshot<Map<String, dynamic>> response = await recipesCollection.where("userId", isEqualTo: uid).get();
    
    final data = response.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => RecipeModel.fromFirestore(doc)).toList();
    return data;
  }

  Future<List<RecipeModel>> getOtherRecipes() async {
    final QuerySnapshot<Map<String, dynamic>> response = await recipesCollection.where("userId", isNotEqualTo: uid).get();

    final data = response.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => RecipeModel.fromFirestore(doc)).toList();
    return data;
  }

  Future addRecipe(String recipeName,
      XFile? image,
      List<String> ingredients,
      String instructions,
      String prepTime,
      String cookTime,
      String portions,
      String kcal,
      String carbs,
      String sugars,
      String fat,
      String protein) async {

    String url = '';
    
    try {

      if (image != null) {
        final ref = FirebaseStorage.instance.ref().child('recipeImages').child('$uid$recipeName${Timestamp.now()}.jpg');
        await ref.putFile(File(image.path));
        url = await ref.getDownloadURL();
      }

      final docData = {
        'userId': uid,
        'recipeName': recipeName,
        'imageUrl': url,
        'ingredients': ingredients,
        'instructions': instructions,
        'prepTime': prepTime,
        'cookTime': cookTime,
        'portions': portions,
        'kcal': double.parse(kcal),
        'carbs': double.parse(carbs),
        'sugars': double.parse(sugars),
        'fat': double.parse(fat),
        'protein': double.parse(protein)
      };

      DocumentReference addedRecipe = await recipesCollection.add(docData);
      DocumentSnapshot doc = await addedRecipe.get();
      final data = doc.data() as Map<String, dynamic>;
      String savedImageUrl = data['imageUrl'];
      return <String>[doc.id, savedImageUrl];
    } on Exception catch (e) {
      return e;
    }
  }
}