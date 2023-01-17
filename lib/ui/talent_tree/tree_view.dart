import 'package:cwtc/ui/talent_tree/update_char_build_dialog/update_char_build_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'build_sequence_dialog.dart/build_sequence_dialog.dart';
import 'save_char_build_dialog/save_char_build_dialog.dart';
import 'spec/spec_view.dart';
import 'tree_viewmodel.dart';

class TreeView extends StatefulWidget {
  const TreeView({Key? key}) : super(key: key);

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double talentImageWidth = SizeConfig.safeBlockHorizontal! * 20;

    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) {
        _tabController.addListener(() => _handleTabChanged(model));

        TabBar tabBar = _buildTabBar(talentImageWidth, (x) => model.getSpecIcon(x));
        AppBar appBar = _buildAppBar(
          model,
          tabBar,
          () => model.getExpansionColor,
          () => model.getClassName,
          () => model.getCharClassColor,
          (x) => model.getSpecIcon(x),
          talentImageWidth,
        );
        Drawer drawer = _buildDrawer(model);

        double appAndTabBarHeight = appBar.preferredSize.height + tabBar.preferredSize.height;

        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: appBar,
            endDrawer: drawer,
            body: TabBarView(
              controller: _tabController,
              children: [
                SpecView(specId: 0, talentImageWidth: talentImageWidth, appAndTabBarHeight: appAndTabBarHeight),
                SpecView(specId: 1, talentImageWidth: talentImageWidth, appAndTabBarHeight: appAndTabBarHeight),
                SpecView(specId: 2, talentImageWidth: talentImageWidth, appAndTabBarHeight: appAndTabBarHeight),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }

  Widget _buildTab(double imageWidth, double imageHeight, String imagePath) {
    return Tab(
      child: Container(
        height: imageWidth,
        width: imageHeight,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(imagePath)),
          borderRadius: BorderRadius.all(Radius.circular(imageWidth)),
          border: Border.all(width: 3, color: Colors.black),
        ),
      ),
    );
  }

  TabBar _buildTabBar(double talentImageWidth, Function(int) specIcon) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.black,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      controller: _tabController,
      tabs: [
        _buildTab(talentImageWidth / 2, talentImageWidth / 2, specIcon(0)),
        _buildTab(talentImageWidth / 2, talentImageWidth / 2, specIcon(1)),
        _buildTab(talentImageWidth / 2, talentImageWidth / 2, specIcon(2)),
      ],
    );
  }

  AppBar _buildAppBar(
    TalentTreeViewModel model,
    TabBar tabBar,
    Function expansionColor,
    Function charClassName,
    Function charClassColor,
    Function(int) specIcon,
    double talentImageWidth,
  ) {
    int spentPointsSpec0 = model.getSpentPoints(0);
    int spentPointsSpec1 = model.getSpentPoints(1);
    int spentPointsSpec2 = model.getSpentPoints(2);
    int spentPoints = spentPointsSpec0 + spentPointsSpec1 + spentPointsSpec2;

    return AppBar(
      leading: const BackButton(),
      foregroundColor: Colors.black87,
      title: Text(charClassName.call(), style: const TextStyle(color: Colors.black87)),
      backgroundColor: charClassColor.call(),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal!, right: SizeConfig.blockSizeHorizontal! * 5),
          child: Center(
              child: Text(
            "${model.getMaxTalentPoints - spentPoints} - $spentPointsSpec0/$spentPointsSpec1/$spentPointsSpec2",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal! * 5,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState!.openEndDrawer();
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(SizeConfig.screenWidth!, SizeConfig.safeBlockVertical! * 4),
        child: Container(color: expansionColor.call(), child: tabBar),
      ),
    );
  }

  void _handleTabChanged(TalentTreeViewModel model) => model.setSpecId = _tabController.index;

  Future<void> _showSaveCharBuildDialog(BuildContext context) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const SaveCharBuildDialogView();
      },
    );
  }

  Future<void> _showUpdateCharBuildDialog(BuildContext context) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const UpdateCharBuildDialogView();
      },
    );
  }

  Future<void> _showBuildSequenceDialog(BuildContext context) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const BuildSequenceDialogView();
      },
    );
  }

  Drawer _buildDrawer(TalentTreeViewModel model) {
    return Drawer(
      child: Container(
        color: model.getExpansionColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 8,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: model.getCharClassColor,
                ),
                child: const Center(
                  child: Text('Options', style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            ListTile(
              title: const Text('Show tooltips?'),
              leading: Icon(Icons.info, color: model.showTooltips ? Colors.green : Colors.red),
              onTap: () {
                model.saveShowTooltips(!model.showTooltips);
                SnackBar snackBar = SnackBar(
                  backgroundColor: model.getCharClassColor,
                  content: Text(
                    model.showTooltips ? "Tooltips activated." : "Tooltips deactivated.",
                    style: const TextStyle(color: Colors.black),
                  ),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            if (model.getCharBuildId < 0) const Divider(),
            if (model.getCharBuildId < 0)
              ListTile(
                title: const Text('Save Build'),
                leading: const Icon(Icons.save),
                onTap: () {
                  Navigator.of(context).pop();
                  _showSaveCharBuildDialog(context);
                },
              ),
            if (model.getCharBuildId >= 0) const Divider(),
            if (model.getCharBuildId >= 0)
              ListTile(
                title: const Text('Update Build'),
                leading: const Icon(Icons.save),
                onTap: () {
                  Navigator.of(context).pop();
                  _showUpdateCharBuildDialog(context);
                },
              ),
            const Divider(),
            ListTile(
              title: const Text('Share Build'),
              leading: const Icon(Icons.share),
              onTap: () {
                int spentPointsSpec0 = model.getSpentPoints(0);
                int spentPointsSpec1 = model.getSpentPoints(1);
                int spentPointsSpec2 = model.getSpentPoints(2);
                Share.share(
                  "${model.getClassName} - $spentPointsSpec0/$spentPointsSpec1/$spentPointsSpec2 - ${model.getShareableLink}",
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Show Build Sequence'),
              leading: const Icon(Icons.list_alt),
              onTap: () => _showBuildSequenceDialog(context),
            ),
            const Divider(),
            ListTile(
              title: const Text('Reset Current Specialization'),
              leading: Icon(Icons.delete, color: Colors.red.shade400),
              onTap: () {
                model.resetSpec();
                SnackBar snackBar = SnackBar(
                  backgroundColor: model.getCharClassColor,
                  content: const Text(
                    'Specialization has been reset.',
                    style: TextStyle(color: Colors.black),
                  ),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Reset the whole Build'),
              leading: Icon(Icons.delete_forever, color: Colors.red.shade900),
              onTap: () {
                model.resetAll();
                SnackBar snackBar = SnackBar(
                  backgroundColor: model.getCharClassColor,
                  content: const Text(
                    'Whole build has been reset.',
                    style: TextStyle(color: Colors.black),
                  ),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
