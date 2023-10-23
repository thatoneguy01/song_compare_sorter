// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "DisneySongSorter"

    Compare_Screen {
        id: compareScreen
        objectName: "compare_screen"
    }

    Filter_Screen {
        id: mainScreen
        objectName: "filter_screen"
    }

}

