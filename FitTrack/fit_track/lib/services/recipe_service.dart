import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/recipe_model.dart';

class RecipeService {

  final String uid;
  RecipeService({ required this.uid });

  final CollectionReference<Map<String, dynamic>> recipesCollection = FirebaseFirestore.instance.collection('recipes');

  Future<List<RecipeModel>> getUserRecipes() async {
    final QuerySnapshot<Map<String, dynamic>> response = await recipesCollection.where("userId", isEqualTo: uid).get();
    
    final data = response.docs.map((doc) => RecipeModel.fromFirestore(doc)).toList();
    return data;
  }
}