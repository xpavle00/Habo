package com.pavlenko.Habo.widgets

import org.junit.Assert.assertEquals
import org.junit.Test
import java.time.Duration
import java.time.LocalDateTime

class MidnightDelayTest {
    @Test
    fun waitsUntilJustPastTheNextMidnight() {
        val now = LocalDateTime.of(2026, 11, 16, 17, 30)
        assertEquals(Duration.ofHours(6).plusMinutes(31), delayUntilDayChange(now))
    }

    @Test
    fun justAfterMidnightWaitsForTheFollowingOne() {
        val now = LocalDateTime.of(2026, 11, 16, 0, 1)
        assertEquals(Duration.ofHours(24), delayUntilDayChange(now))
    }

    @Test
    fun lastDayOfYearRollsIntoTheNext() {
        val now = LocalDateTime.of(2026, 12, 31, 23, 59, 30)
        assertEquals(Duration.ofSeconds(90), delayUntilDayChange(now))
    }
}
