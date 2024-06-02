import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants/fonts.dart';
import '../../domain/bloc/about_bloc.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutBloc(),
      child: BlocConsumer<AboutBloc, AboutState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// Text
                SizedBox(
                  width: 100,
                  height: 200,
                  child: Text(
                    "En 2003, un Ingénieur Agronome passionné a jeté les bases d'un complexe scolaire novateur au Mali. Animé par le désir ardent d'améliorer l'éducation des élèves, il a créé cet établissement avec la vision de former une nouvelle génération de leaders éclairés.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppFonts.sacramentoRegular,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
               SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: Text(
                    "Depuis sa création, le complexe scolaire a été un phare de l'apprentissage, offrant un environnement propice à l'épanouissement académique et personnel des élèves maliens.",

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.sacramentoRegular,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Text(
                      "Grâce à cet engagement envers l'éducation, le complexe a laissé une empreinte positive sur la communauté éducative du pays, créant un héritage durable pour les générations futures"),
                )

                /// Images
                /// Text
              ],
            ),
          );
        },
      ),
    );
  }
}
