import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/teams_cubit/teams_doctor_cubit/teams_doctor_cubit.dart';
import '../../teams_doctor_screen/teams_doctor_screen.dart';
import 'follower_card.dart';
import 'no_followers_widget.dart';

class ListInsideContainer extends StatefulWidget {
  final List viewedList;
  const ListInsideContainer({Key? key, required this.viewedList})
      : super(key: key);

  @override
  State<ListInsideContainer> createState() => _ListInsideContainerState();
}

class _ListInsideContainerState extends State<ListInsideContainer>
    with TickerProviderStateMixin {
  //
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: kNoFollowersAnimationDuration),
  );
  //
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.reset();
    _controller.forward();
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<TeamsCubit>(context).getFollowingInfo();
      },
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: widget.viewedList.isEmpty
              ? NoFollowersWidget(
                  msg: role == 'doctor'
                      ? kNoFollowingsYet
                      : BlocProvider.of<TeamsCubit>(context).isFollowersSelected
                          ? kNoFollowersYet
                          : kNoFollowingsYet,
                )
              : ListView.builder(
                  itemCount: widget.viewedList.length,
                  // physics: BouncingScrollPhysics(),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                      child: FollowerCard(
                        follower: widget.viewedList[index],
                        onTap: () async {
                          if (role == 'patient' &&
                              widget.viewedList[index].isPatient == false) {
                            //
                            Navigator.of(context).pushNamed(
                                TeamsDoctorScreen.routeName,
                                arguments: widget.viewedList[index].username);
                            //
                            await BlocProvider.of<TeamsDoctorCubit>(context)
                                .getDoctorInfo(widget.viewedList[index].id);
                          } else if (role != 'patient') {
                            //navigate to teams_patient_screen
                          }
                        },
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
